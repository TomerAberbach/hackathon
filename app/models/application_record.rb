##
# An abstract class representing an entity in the database.
# Instances of this class represent rows in a table on the database.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ##
  # Defines a setter which nicely formats the +String+ argument for before setting
  # for each of the given +attributes+.
  # Options:
  # +options[:strip]+ - Removes whitespace from the ends of the +String+ (default: +true+).
  # +options[:single_spaces]+ - Replaces sequences of consecutive spaces in the +String+ with single spaces (default: +true+).
  def self.text_writer(*attributes, **options)
    # This multi-statement lambda construction only executes the conditionals once
    operations = []
    operations.push(lambda(&:strip)) if options.fetch(:strip, true)
    operations.push(lambda { |s| s.gsub(/\s+/, ' ') }) if options.fetch(:single_spaces, true)

    # Function applying selected operations
    transform = lambda { |value| operations.reduce(value) { |acc, operation| operation.call(acc) } }

    # Defines the setter method for each attribute
    attributes.each do |attribute|
      define_method("#{attribute}=") do |value|
        # Super method sets attribute normally
        super(
          if value.nil?
            value
          elsif value.kind_of?(Array)
            value.lazy.select { |element| !element.nil? }.map { |element| transform.call(element) }.to_a
          else
            transform.call(value)
          end
        )
      end
    end
  end

  ##
  # Adds validation which checks that the given +attributes+ are proper images.
  def self.validates_imageness_of(*attributes)
    validates(
      *attributes,
      allow_nil: true,
      content_type: {
        in: %w[image/png image/jpg image/jpeg image/svg+xml],
        message: 'must be a png, jpg, or svg'
      },
      size: {
        less_than: 10.megabytes,
        message: 'must be less than 10 MB'
      })
  end

  ##
  # Adds validation which checks that the given +attributes+ are proper documents.
  def self.validates_documentness_of(*attributes)
    validates(
      *attributes,
      attached: true,
      content_type: {
        in: %w[text/plain application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document],
        message: 'must be a txt, pdf, doc, or docx'
      },
      size: {
        less_than: 10.megabytes,
        message: 'must be less than 10 MB'
      })
  end
end
