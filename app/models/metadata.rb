##
# A class representing the information of the hackathon associated with the website.
# There should only ever be one row in the +metadata+ table associated with this model.
class Metadata < ApplicationRecord
  # Validation
  validates_presence_of :name, :description, :keywords, :email, :capacity
  validates_numericality_of :capacity, greater_than: 0
  validates_imageness_of :logo
  validate on: :create do |metadata|
    # Validates that there is only one metadata info instance in the database at any given time
    if ::Metadata.exists?
      metadata.errors[:base] << 'there must only be one metadata instance for the website'
    end
  end
  validate do |metadata|
    if metadata.capacity < Hacker.registered.count
      metadata.errors[:capacity] << 'capacity cannot be set lower than the number of registered hackers'
    end
  end

  # Associations
  has_one_attached :logo

  # Transformation
  serialize :keywords, Array
  text_writer :name, :description, :address_one, :address_two, :city, :state, :zip_code, :keywords
end
