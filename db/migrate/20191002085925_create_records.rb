# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :progress
      t.text :supplement
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
