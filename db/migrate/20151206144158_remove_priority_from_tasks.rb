class RemovePriorityFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :priority, :integer
  end
end
