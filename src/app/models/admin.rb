##
# A class representing an admin involved in the planning of the hackathon of this website.
# Instances of this class represent rows in the +admins+ table on the database.
class Admin < ApplicationRecord
  # Devise features
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :invitable

  def super_admin?
    Admin.order(:created_at).first == self
  end
end
