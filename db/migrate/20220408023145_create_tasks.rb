class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :expired_on
      t.integer :status
      t.references :user, foreign_key: true
      t.references :pair, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
