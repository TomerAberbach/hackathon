##
# A class representing a controller which handles HTTP requests
# relating to the website's +MailingList+ instance.
class MailingListsController < ApplicationController
  before_action :registration_is_not_open!

  ##
  # PATCH /mailing_list
  def update
    MailingList.add(params.fetch(:email, ''))
    redirect_to root_path
  end

  private

  ##
  # Redirects to the website's root if registration is open.
  def registration_is_not_open!
    if ::Metadata.first.registration_open
      redirect_to root_path
    end
  end
end
