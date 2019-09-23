class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :leader_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
