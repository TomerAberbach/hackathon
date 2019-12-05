##
# A class representing a controller which handles internal HTTP requests
# relating to the +Admin+ class.
class Dashboard::AdminsController < ApplicationController
  # Events
  before_action :initialize_admin, only: %i[destroy]

  ##
  # GET /dashboard/admins
  def index
    @admins = Admin.all
  end

  ##
  # POST /dashboard/admins
  def create
    Admin.invite!(email: permitted_params[:email])
    redirect_to dashboard_admins_path, notice: 'The admin was successfully invited.'
  end

  ##
  # GET /dashboard/admins/new
  def new
    @admin = Admin.new
  end

  ##
  # DELETE /dashboard/admins/:id
  def destroy
    if @admin == current_admin || @admin.super_admin?
      redirect_to dashboard_admins_path
    else
      @admin.destroy
      redirect_to dashboard_admins_path, notice: 'The admin was successfully deleted.'
    end
  end

  private

  ##
  # Initializes the +admin+ field from the query +params+.
  def initialize_admin
    @admin = Admin.find(params[:id])
  end

  ##
  # Returns the query +params+ filtered for permissible parameters.
  def permitted_params
    params.require(:admin).permit(:email)
  end
end
