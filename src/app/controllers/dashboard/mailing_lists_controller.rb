##
# A class representing a controller which handles internal HTTP requests
# relating to the +MailingList+ class.
class Dashboard::MailingListsController < ApplicationController
  # Events
  before_action :initialize_emails

  ##
  # GET /dashboard/mailing_list
  def show; end

  ##
  # GET /dashboard/mailing_list/email
  def email
    if @emails.none?
      redirect_to dashboard_mailing_list_path
    end

    @errors = []
  end

  ##
  # POST /dashboard/mailing_list/email
  def deliver
    if @emails.none?
      redirect_to dashboard_mailing_list_path
    end

    @errors = []

    %w[subject content].each do |key|
      @errors << "#{key} must not be blank" unless params.key?(key.to_sym) && params[key.to_sym].present?
    end

    if @errors.empty?
      count = 0
      @emails.each do |email|
        HackerMailer.with(email: email, subject: params[:subject], content: params[:content]).email.deliver
        count += 1
      end

      redirect_to dashboard_mailing_list_path, notice: "The #{'email'.pluralize(count)} #{count == 1 ? 'was' : 'were'} successfully sent."
    else
      render 'email'
    end
  end

  ##
  # DELETE /dashboard/mailing_list
  def destroy
    MailingList.remove(params.fetch(:email, ''))
    redirect_to dashboard_mailing_list_path
  end

  private

  ##
  # Initializes the +emails+ field.
  def initialize_emails
    @emails = MailingList.first.emails
  end
end
