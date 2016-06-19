class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :content
      t.boolean :is_public
      t.integer :capacity

      t.string :foobar

      t.timestamps null: false
    end
  end
end
