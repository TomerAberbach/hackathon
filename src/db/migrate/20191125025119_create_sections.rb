# frozen_string_literal: true

##
# Adds the +sections+ table to the database.
class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
