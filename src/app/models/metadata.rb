##
# A class representing the information of the hackathon associated with the website.
# There should only ever be one row in the +metadata_infos+ table associated with this model.
class Metadata < ApplicationRecord
  # Validation
  validates_presence_of :name, :description, :tags, :host, :email, :capacity
  validates_numericality_of :capacity, greater_than: 0
  validates_imageness_of :logo
  validate on: :create do |metadata|
    # Validates that there is only one metadata info instance in the database at any given time
    if Metadata.exists?
      metadata.errors[:base] << 'there must only be one metadata instance for the website'
    end
  end

  # Associations
  has_one_attached :logo

  # Transformation
  serialize :tags, Array
  text_writer :name, :description, :host, :address_one, :address_two,
              :city, :state, :zip_code, :tags
end
