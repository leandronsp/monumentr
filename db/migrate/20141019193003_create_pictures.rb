class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures, id: false do |t|
      t.string :uuid, null: false
      t.string :extension

      t.timestamps
    end

    add_index :pictures, :uuid, unique: true
  end
end
