class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :user_id, false
    change_column_null :tasks, :expired_on, false
    change_column_null :tasks, :status, false   
  end
end
