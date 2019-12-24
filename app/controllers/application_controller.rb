##
# An abstract class representing a controller which handles HTTP requests.
class ApplicationController < ActionController::Base
  # Turns on request forgery protection
  protect_from_forgery with: :exception

  # Sanitizes incoming url parameters for devise controllers
  before_action :sanitize_devise_params, if: :devise_controller?

  # Ensures the user is authenticated if the current route is internal
  before_action :authenticate_admin!, if: :dashboard_controller?

  # Initializes the +@metadata+ field
  before_action :initialize_metadata

  protected

  ##
  # Filters incoming url parameters for devise controllers.
  def sanitize_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
  end

  ##
  # Returns a boolean indicating if this is a controller for a dashboard route.
  def dashboard_controller?
    self.class.module_parent == Dashboard
  end

  ##
  # Initializes the +@metadata+ field from the database.
  def initialize_metadata
    @metadata = Metadata.first
  end

  private

  ##
  # Overrides the +sign_out+ redirect path method so after sign out the user
  # is redirected to their website root.
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      dashboard_root_path
    else
      root_path
    end
  end

  ##
  # Overrides the +sign_in+ redirect path method so after sign in the user
  # is redirected to their dashboard.
  def after_sign_in_path_for(resource)
    if resource.class.name == 'Admin'
      dashboard_metadata_path
    else
      hacker_path
    end
  end
end
