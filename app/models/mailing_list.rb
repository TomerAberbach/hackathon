##
# A class representing the website's mailing list.
# There should only ever be one row in the +mailing_list+ table associated with this model.
class MailingList < ApplicationRecord
  # Validation
  validate on: :create do |metadata|
    # Validates that there is only one mailing list instance in the database at any given time
    if MailingList.exists?
      metadata.errors[:base] << 'there must only be one mailing list instance for the website'
    end
  end

  # Transformation
  serialize :emails, Array

  ##
  # Adds the given +email+ to the mailing list.
  def self.add(email)
    if !email.blank? and !email.index('@').nil?
      mailing_list = MailingList.first
      mailing_list.update(emails: [email].union(mailing_list.emails))
    end
  end

  ##
  # Removes the given +email+ from the mailing list.
  def self.remove(email)
    mailing_list = MailingList.first
    mailing_list.update(emails: mailing_list.emails.without(email))
  end
end
