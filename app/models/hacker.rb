require 'csv'

##
# A class representing a hacker wanting to attend the hackathon of this website.
# Instances of this class represent rows in the +hackers+ table on the database.
class Hacker < ApplicationRecord
  # Devise features
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  # Validation
  validates_presence_of :email, :first_name, :last_name, :level_of_study, :major,
                        :shirt_size, :dietary_restrictions, :date_of_birth,
                        :gender, :phone_number, :school
  validates_uniqueness_of :email
  validates_inclusion_of :level_of_study, in: ->(_) { Hacker.levels_of_study }
  validates_inclusion_of :major, in: ->(_) { Hacker.majors }
  validates_inclusion_of :shirt_size, in: ->(_) { Hacker.shirt_sizes }
  validates_documentness_of :resume
  validate do |hacker|
    # Validates that the MLH agreement is agreed to i necessary
    if ::Metadata.first.mlh and !hacker.mlh_agreement
      hacker.errors[:base] << 'you must agree to the MLH Code of Conduct, Data Sharing, and Terms & Conditions'
    end
  end

  # Associations
  has_one_attached :resume

  # Callbacks
  after_validation do |hacker|
    if hacker.resume.attached?
      base = "#{hacker.first_name.parameterize}-#{hacker.last_name.parameterize}"
      ext = hacker.resume.blob.filename.extension_with_delimiter
      hacker.resume.blob.update(filename: "#{base}#{ext}")
    end
  end
  after_destroy do |_|
    Hacker.recompute_waitlist
  end

  # Transformation
  text_writer :first_name, :last_name, :level_of_study, :major,
              :shirt_size, :dietary_restrictions, :special_needs,
              :gender, :phone_number, :school

  ##
  # Returns a list of permissible levels of study.
  def self.levels_of_study
    [
      'High School / Secondary School',
      'University (Undergraduate)',
      'University (Master\'s / Doctoral)',
      'Vocational / Code School',
      'Not Currently a Student',
      'Other'
    ]
  end

  ##
  # Returns an array of permissible majors.
  def self.majors
    [
      'Accounting',
      'Aerospace Engineering',
      'Agricultural Engineering',
      'Applied Mathematics',
      'Architecture',
      'Biochemistry',
      'Bioengineering',
      'Bioinformatics',
      'Biological Sciences',
      'Biology',
      'Biomedical Engineering',
      'Biotechnology',
      'Building Construction Management',
      'Business',
      'Business Administration',
      'Business Analytics',
      'Chemical Engineering',
      'Chemistry',
      'Civil Engineering',
      'Cognitive Science',
      'Communications',
      'Computational Biology',
      'Computational Media',
      'Computer Engineering',
      'Computer Science',
      'Computer Information Systems',
      'Computer Technologies',
      'Computing Security',
      'Culinary Arts',
      'Cyber Operations',
      'Data Science',
      'Design',
      'Economics',
      'Electrical Engineering',
      'Engineering',
      'Engineering Management',
      'Engineering Physics',
      'Engineering Science',
      'English',
      'Film',
      'Finance',
      'Game Design and Development',
      'Geophysics',
      'Graphic Design',
      'Human Centered Design',
      'Human Computer Interaction',
      'Humanities',
      'Individualized Major',
      'Industrial and Systems Engineering',
      'Industrial and Operations Engineering',
      'Industrial Engineering',
      'Informatics',
      'Information Science',
      'Information Systems',
      'Information Technology',
      'Interaction Design',
      'Interactive Multimedia',
      'Interactive Telecommunications Program (ITP)',
      'International Relations',
      'Journalism',
      'Linguistics',
      'Management',
      'Management Information Systems',
      'Marketing',
      'Materials Science',
      'Mathematics',
      'Mechanical Engineering',
      'Mechatronics',
      'Mechatronics Engineering',
      'Media Arts and Sciences',
      'Music Computing',
      'Nanoengineering',
      'Network Security',
      'Neurobiology/Cognitive Science',
      'Neuroscience',
      'New Media Design',
      'Operations Research Management Science',
      'Organizational',
      'Philosophy',
      'Physics',
      'Political Science',
      'Poultry Science',
      'Product Design',
      'Psych',
      'Psychology',
      'Robotics Engineering',
      'Robotics',
      'Software Engineering',
      'Statistics',
      'Systems Design Engineering',
      'Technology Management',
      'Theatre and Linguistics',
      'Other'
    ]
  end

  ##
  # Returns an array of permissible shirt sizes.
  def self.shirt_sizes
    [
      'Women\'s - XXS',
      'Women\'s - XS',
      'Women\'s - S',
      'Women\'s - M',
      'Women\'s - L',
      'Women\'s - XL',
      'Women\'s - XXL',
      'Unisex - XXS',
      'Unisex - XS',
      'Unisex - S',
      'Unisex - M',
      'Unisex - L',
      'Unisex - XL',
      'Unisex - XXL'
    ]
  end

  ##
  # Returns an array of permissible dietary restrictions.
  def self.dietary_restrictions
    %w[None Vegetarian Gluten-Free Vegan]
  end

  ##
  # Returns an array of permissible genders.
  def self.genders
    ['Female', 'Male', 'Non-binary', 'I prefer not to say']
  end

  ##
  # Returns true iff the hackathon has not exceeded its capacity as defined by
  # the +capacity+ attribute of the +Metadata+ class.
  def self.openings?
    Hacker.registered.count < ::Metadata.first.capacity
  end

  ##
  # Returns a query of registered +Hacker+ instances.
  def self.registered
    Hacker.where(waitlisted: false)
  end

  ##
  # Returns a query of waitlisted +Hacker+ instances.
  def self.waitlisted
    Hacker.where(waitlisted: true)
  end

  ##
  # Moves hackers of the waitlist if possible.
  def self.recompute_waitlist
    if Hacker.waitlisted.any?
      capacity = Metadata.first.capacity
      registered_count = Hacker.registered.count
      open_spots = capacity - registered_count

      if open_spots > 0
        ActiveRecord::Base.transaction do
          # Lower id hackers signed up first (ids of deregistered hackers are NOT reused)
          Hacker
            .where(waitlisted: true)
            .order(id: :asc)
            .limit(open_spots)
            .update_all!(waitlisted: false)

          # Should not happen, but if it does we should abort the transaction
          if Hacker.registered.count > capacity
            raise 'abort'
          end
        end
      end
    end
  end

  ##
  # Returns a +CSV+ instance containing +Hacker+ attributes with the exception
  # of resumes.
  def self.to_csv
    attributes = %w[email first_name last_name level_of_study major
                    shirt_size dietary_restrictions special_needs
                    date_of_birth gender phone_number school]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |hacker|
        csv << attributes.map { |attribute| hacker.send(attribute) }
      end
    end
  end
end
