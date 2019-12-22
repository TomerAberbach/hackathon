##
# A class representing a controller which handles internal HTTP requests
# relating to the +Hacker+ class.
class Dashboard::HackersController < ApplicationController
  include ActiveStorage::SendZip

  # Events
  before_action :initialize_hacker, only: %i[show check_in uncheck_in destroy]

  ##
  # GET /dashboard/hackers
  def index
    @hackers = Hacker.page(params[:page])

    respond_to do |format|
      format.html do
        @hackers = Hacker.page(params[:page])
      end
      format.csv do
        send_data Hacker.to_csv, filename: "hackers-#{Date.today}.csv"
      end
    end
  end

  ##
  # GET /dashboard/hackers/resumes
  def resumes
    send_zip ActiveStorage::Attachment.where(record: Hacker.all), filename: 'resumes.zip'
  end

  ##
  # GET /dashboard/hackers/email
  def email
    if Hacker.none?
      redirect_to dashboard_hackers_path
    end

    @errors = []
  end

  ##
  # POST /dashboard/hackers/email
  def deliver
    if Hacker.none?
      redirect_to dashboard_hackers_path
      return
    end

    @errors = []

    %w[subject content].each do |key|
      @errors << "#{key} must not be blank" unless params.key?(key.to_sym) && params[key.to_sym].present?
    end

    if @errors.empty?
      count = 0
      Hacker.all.each do |hacker|
        HackerMailer.with(email: hacker.email, subject: params[:subject], content: params[:content]).email.deliver
        count += 1
      end

      redirect_to dashboard_hackers_path, notice: "The #{'email'.pluralize(count)} #{count == 1 ? 'was' : 'were'} successfully sent."
    else
      render 'email'
    end
  end

  ##
  # GET /dashboard/hackers/:id
  def show; end

  ##
  # PATCH /dashboard/hackers/:id/check_in
  def check_in
    unless @hacker.checked_in
      @hacker.update(checked_in: true)
    end

    redirect_to dashboard_hackers_path
  end

  ##
  # PATCH /dashboard/hackers/:id/uncheck_in
  def uncheck_in
    if @hacker.checked_in
      @hacker.update(checked_in: false)
    end

    redirect_to dashboard_hackers_path
  end

  ##
  # DELETE /dashboard/hackers/:id
  def destroy
    @hacker.destroy
    redirect_to dashboard_hackers_path, notice: 'The hacker was successfully deleted.'
  end

  private

  ##
  # Initializes the +hacker+ field from the query +params+.
  def initialize_hacker
    @hacker = Hacker.find(params[:id])
  end

  ##
  # Returns the query +params+ filtered for permissible parameters.
  def permitted_params
    params.require(:hacker).permit(:email)
  end
end
