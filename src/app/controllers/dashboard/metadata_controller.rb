##
# An class representing a controller which handles internal HTTP requests
# relating to the +Metadata+ class. Note that +@metadata+ is initialized
# before each action in +ApplicationController+.
class Dashboard::MetadataController < ApplicationController
  ##
  # GET /dashboard/metadata
  def show; end

  ##
  # GET /dashboard/metadata/edit
  def edit; end

  ##
  # PATCH/PUT /dashboard/metadata
  def update
    if @metadata.update(permitted_params)
      redirect_to dashboard_metadata_path
    else
      render :edit
    end
  end

  private

  ##
  # Returns the query +params+ filtered for permissible parameters.
  def permitted_params
    p = params.require(:metadata).permit(
      :name, :description, :tags, :host, :email, :capacity, :date, :time,
      :address_one, :address_two, :city, :state, :zip_code
    )
    p[:tags] = p[:tags].split(',')
    p
  end
end
