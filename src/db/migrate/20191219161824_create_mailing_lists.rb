# frozen_string_literal: true

##
# Adds the +mailing_lists+ table to the database.
class CreateMailingLists < ActiveRecord::Migration[6.0]
  def change
    create_table :mailing_lists do |t|
      t.text :emails, null: true

      t.timestamps
    end
  end
end
