##
# A class representing a controller which handles HTTP requests relating
# to account password information of +Admin+ instances.
# Overrides the default functionality of the +Devise::PasswordsController+.
class Admins::PasswordsController < Devise::PasswordsController
  protected

  def after_sending_reset_password_instructions_path_for(resource)
    dashboard_root_path
  end
end
