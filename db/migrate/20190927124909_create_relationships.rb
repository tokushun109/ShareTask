# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.string :status

      t.timestamps
      t.index %i[user_id group_id], unique: true
    end
  end
end
