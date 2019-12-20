##
# A class representing a controller which handles HTTP requests relating
# to registering and updating account information of +Hacker+ instances.
# Overrides the default functionality of the +Devise::RegistrationsController+.
class Hackers::RegistrationsController < Devise::RegistrationsController
  before_action :registration_is_open!

  protected

  def after_sign_up_path_for(resource)
    hacker_path
  end

  def after_update_path_for(resource)
    hacker_path
  end

  private

  ##
  # Returns the query +params+ filtered for permissible sign up parameters.
  def sign_up_params
    p = params.require(:hacker).permit(*([:first_name, :last_name, :level_of_study, :major,
                                          :shirt_size, :dietary_restrictions, :special_needs,
                                          :date_of_birth, :gender, :phone_number, :school, :resume,
                                          Metadata.first.mlh ? :mlh_agreement : nil, :email, :password, :password_confirmation].compact))
    if p.has_key?(:mlh_agreement)
      p[:mlh_agreement] = p[:mlh_agreement] == 'I agree'
    end

    p[:waitlisted] = !Hacker.openings?
    p
  end

  ##
  # Returns the query +params+ filtered for permissible account update parameters.
  def account_update_params
    params.require(:hacker).permit(:first_name, :last_name, :level_of_study, :major,
                                   :shirt_size, :dietary_restrictions, :special_needs,
                                   :date_of_birth, :gender, :phone_number, :school, :resume,
                                   :email, :password, :password_confirmation, :current_password)
  end

  ##
  # Redirects to the website's root if registration is not open.
  def registration_is_open!
    unless ::Metadata.first.registration_open
      redirect_to root_path
    end
  end
end
