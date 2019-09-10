class Hacker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :checked_in, :waitlisted, :first_name, :last_name, :level_of_study,
                        :major, :shirt_size, :dietary_restrictions, :special_needs, :date_of_birth,
                        :gender, :education
end
