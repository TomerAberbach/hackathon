class Hacker < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  validates_presence_of :first_name, :last_name, :level_of_study,
                        :major, :shirt_size, :dietary_restrictions, :special_needs, :date_of_birth,
                        :gender, :education, :checked_in, :waitlisted
end
