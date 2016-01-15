class AddIndexes < ActiveRecord::Migration
  def change
    add_index :projects,  :user_id
    add_index :tasks,     :project_id
    add_index :tasks,     :user_id
  end
end
