class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.timestamps
    end

    add_index :collections, :user_id
  end
end
