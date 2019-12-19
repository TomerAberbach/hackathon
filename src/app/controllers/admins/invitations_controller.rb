##
# A class representing a controller which handles HTTP requests relating
# to inviting of +Admin+ instances.
# Overrides the default functionality of the +Devise::InvitationsController+.
class Admins::InvitationsController < Devise::InvitationsController
  protected

  def after_accept_path_for(resource)
    dashboard_metadata_path
  end
end
