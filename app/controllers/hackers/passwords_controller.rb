##
# A class representing a controller which handles HTTP requests relating
# to account password information of +Hacker+ instances.
# Overrides the default functionality of the +Devise::PasswordsController+.
class Hackers::PasswordsController < Devise::PasswordsController
  before_action :registration_is_open!

  protected

  def after_sending_reset_password_instructions_path_for(resource)
    new_hacker_session_path
  end

  private

  ##
  # Redirects to the website's root if registration is not open.
  def registration_is_open!
    unless ::Metadata.first.registration_open
      redirect_to root_path
    end
  end
end
