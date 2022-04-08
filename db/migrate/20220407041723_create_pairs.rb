class CreatePairs < ActiveRecord::Migration[6.0]
  def change
    create_table :pairs do |t|
      t.date :weddingday_on
      t.integer :season, default: 0
      t.bigint :owner_id, null:false
      
      t.timestamps
    end
  end
end
