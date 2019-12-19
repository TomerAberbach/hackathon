##
# A class representing a controller which handles HTTP requests relating
# to updating account information of +Admin+ instances.
# Overrides the default functionality of the +Devise::RegistrationsController+.
class Admins::RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(resource)
    dashboard_metadata_path
  end
end
