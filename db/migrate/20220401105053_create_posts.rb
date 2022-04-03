class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text "content"
      t.text "image"
      t.integer "category", default: 0, null: false

      t.timestamps
    end
  end
end