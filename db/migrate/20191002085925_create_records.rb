class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :progress
      t.string :supplement
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
