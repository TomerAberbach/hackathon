##
# A class representing a user involved in the planning of the hackathon of this website.
# Instances of this class represent rows in the +users+ table on the database.
class User < ApplicationRecord
  # Devise features
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :invitable

  def super_admin?
    User.order(:created_at).first == self
  end
end