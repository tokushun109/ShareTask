class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :post_user, foreign_key: { to_table: :users }
      t.references :post_group, foreign_key: { to_table: :groups }
      t.string :in_charge
      t.datetime :time_limit

      t.timestamps
    end
  end
end
