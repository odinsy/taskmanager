class RemoveParentIdFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :parent_id, :integer
  end
end
