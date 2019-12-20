##
# A class representing a controller which handles HTTP requests
# relating to the currently authenticated +Hacker+ (+current_hacker+).
class HackersController < ApplicationController
  # Ensures the hacker is authenticated
  before_action :registration_is_open!
  before_action :authenticate_hacker!

  ##
  # GET /hacker
  def show; end

  private

  ##
  # Redirects to the website's root if registration is not open.
  def registration_is_open!
    unless ::Metadata.first.registration_open
      redirect_to root_path
    end
  end
end
