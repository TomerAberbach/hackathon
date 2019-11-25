##
# A class representing a section in the home page of this website.
# Instances of this class represent rows in the +sections+ table on the database.
class Section < ApplicationRecord
  # Validation
  validates_presence_of :title, :content

  # Associations
  has_rich_text :content

  # Transformation
  text_writer :title
end
