##
# A class that sends emails to hackers.
class HackerMailer < ApplicationMailer
  ##
  # Creates an email for the given +email+ with the given +subject+ as the email subject
  # and the given +content+ in the email body.
  def email
    @content = params[:content]
    mail(to: params[:email], subject: params[:subject])
  end
end
