class AddForeignKeyToPairs < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :pairs, :users, column: :owner_id
    add_index :pairs, :owner_id
  end
end
