# frozen_string_literal: true

##
# Adds the +hackers+ table to the database.
class DeviseCreateHackers < ActiveRecord::Migration[6.0]
  def change
    create_table :hackers do |t|
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.string :level_of_study, null: false, default: ''
      t.string :major, null: false, default: ''
      t.string :shirt_size, null: false, default: ''
      t.string :dietary_restrictions, null: false, default: ''
      t.string :special_needs, null: false, default: ''
      t.date :date_of_birth, null: false
      t.string :gender, null: false, default: ''
      t.string :phone_number, null: false, default: ''
      t.string :school, null: false, default: ''
      t.boolean :mlh_agreement, null: false, default: false

      t.boolean :checked_in, null: false, default: false
      t.boolean :waitlisted, null: false

      t.timestamps null: false

      ## Devise
      # Database authenticatable
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      # Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at
    end

    # Devise
    add_index :hackers, :email, unique: true
    add_index :hackers, :reset_password_token, unique: true
  end
end
