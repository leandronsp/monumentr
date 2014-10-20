class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :collection_id
    end

    add_index :monuments, :collection_id
  end
end
