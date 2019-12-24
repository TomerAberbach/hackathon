##
# A class representing a controller which handles internal HTTP requests
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
    if !permitted_params[:mlh].nil? and @metadata.mlh != permitted_params[:mlh] and Hacker.any?
      redirect_to dashboard_metadata_path, alert: 'MLH integration cannot be toggled after hackers have begun registering.'
      return
    end

    if @metadata.update(permitted_params)
      # Capacity may have been changed
      Hacker.recompute_waitlist

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
      :name, :description, :keywords, :logo, :email,
      :capacity, :start_date, :start_time, :end_date, :end_time,
      :address_one, :address_two, :city, :state, :zip_code, :mlh,
      :mlh_banner_code, :registration_open
    )
    p[:keywords] = p[:keywords].split(',') unless p[:keywords].nil?
    p[:mlh] = p[:mlh] == '1'
    p[:registration_open] = p[:registration_open] == '1'
    p
  end
end
