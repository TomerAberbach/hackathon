# frozen_string_literal: true

##
# Adds the +admins+ table to the database.
class DeviseCreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.timestamps null: false

      ## Devise
      # Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Invitable
      t.string   :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer  :invitation_limit
      t.integer  :invited_by_id
      t.string   :invited_by_type
    end

    # Devise
    add_index :admins, :email, unique: true
    add_index :admins, :reset_password_token, unique: true
    add_index :admins, :invitation_token, unique: true
  end
end
