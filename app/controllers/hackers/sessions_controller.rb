##
# A class representing a controller which handles HTTP requests relating
# to signing in and out of +Hacker+ instances.
# Overrides the default functionality of the +Devise::SessionsController+.
class Hackers::SessionsController < Devise::SessionsController
  before_action :registration_is_open!

  private

  ##
  # Redirects to the website's root if registration is not open.
  def registration_is_open!
    unless ::Metadata.first.registration_open
      redirect_to root_path
    end
  end
end
