##
# A class representing a section in the home page of this website.
# Instances of this class represent rows in the +sections+ table on the database.
class Section < ApplicationRecord
  # Validation
  validates_presence_of :title

  # Associations
  has_rich_text :content

  # Transformation
  text_writer :title

  def previous
    Section.where('id < ?', id).last
  end

  def next
    Section.where('id > ?', id).first
  end

  def self.swap(first_section, second_section)
    ActiveRecord::Base.transaction do
      bogus_id = Section.order(id: :desc).first.id + 1

      first_section_id = first_section.id
      first_section.id = bogus_id
      first_section.save!

      second_section_id = second_section.id
      second_section.id = first_section_id
      second_section.save!

      first_section.id = second_section_id
      first_section.save!
    end
  end
end
