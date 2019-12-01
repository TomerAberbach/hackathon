class Dashboard::AdminsController < ApplicationController

  before_action :initialize_admin, only: %i[destroy]

  def index
    @admins = Admin.all
  end

  def create
    Admin.invite!(email: permitted_params[:email])
    redirect_to dashboard_admins_path, notice: 'The admin was successfully invited.'
  end

  def new
    @admin = Admin.new
  end

  def destroy
    @admin.destroy
    redirect_to dashboard_admins_path, notice: 'The admin was successfully deleted.'
  end

  private

  ##
  # Initializes the +section+ field from the query +params+.
  def initialize_admin
    @admin = Admin.find(params[:id])
  end

  ##
  # Returns the query +params+ filtered for permissible parameters.
  def permitted_params
    params.require(:admin).permit(:email)
  end
end
