##
# A class representing a controller which handles internal HTTP requests
# relating to the +Section+ class.
class Dashboard::SectionsController < ApplicationController
  # Events
  before_action :initialize_section, only: %i[edit show update destroy]

  ##
  # GET /dashboard/sections
  def index
    @sections = Section.all
  end

  ##
  # POST /dashboard/sections
  def create
    @section = Section.new(permitted_params)

    if @section.save
      redirect_to dashboard_section_path(@section), notice: 'The section was successfully created.'
    else
      render :new
    end
  end

  ##
  # GET /dashboard/sections/new
  def new
    @section = Section.new
  end

  ##
  # GET /dashboard/sections/:id/edit
  def edit; end

  ##
  # GET /dashboard/sections/:id
  def show; end

  ##
  # GET /dashboard/sections/:id
  def update
    if @section.update(permitted_params)
      redirect_to dashboard_section_path(@section), notice: 'The section was successfully updated.'
    else
      render :edit
    end
  end

  ##
  # DELETE /dashboard/sections/:id
  def destroy
    @section.destroy
    redirect_to dashboard_sections_path, notice: 'The section was successfully deleted.'
  end

  private

  ##
  # Initializes the +section+ field from the query +params+.
  def initialize_section
    @section = Section.find(params[:id])
  end

  ##
  # Returns the query +params+ filtered for permissible parameters.
  def permitted_params
    params.require(:section).permit(:title, :content)
  end
end
