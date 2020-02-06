class AddPictureToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :picture, :string
  end
end
