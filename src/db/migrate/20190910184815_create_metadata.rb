# frozen_string_literal: true

##
# Adds the +metadata+ table to the database.
class CreateMetadata < ActiveRecord::Migration[6.0]
  def change
    create_table :metadata do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :tags, null: false
      t.string :host, null: false
      t.string :email, null: false
      t.integer :capacity, null: false
      t.date :start_date, null: true
      t.time :start_time, null: true
      t.date :end_date, null: true
      t.time :end_time, null: true
      t.string :address_one, null: true
      t.string :address_two, null: true
      t.string :city, null: true
      t.string :state, null: true
      t.string :zip_code, null: true

      t.timestamps null: false
    end
  end
end
