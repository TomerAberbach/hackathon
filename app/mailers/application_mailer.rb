##
# A class that sends emails.
class ApplicationMailer < ActionMailer::Base
  default from: Metadata.first.email
  layout 'mailer'

  before_action :initialize_metadata

  private

  def initialize_metadata
    @metadata = Metadata.first
  end
end
