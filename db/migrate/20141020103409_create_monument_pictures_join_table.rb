class CreateMonumentPicturesJoinTable < ActiveRecord::Migration
  def change
    create_table :monument_pictures do |t|
      t.integer :monument_id
      t.string :picture_id
      t.timestamps
    end

    add_index :monument_pictures, [:monument_id, :picture_id], unique: true
  end
end
