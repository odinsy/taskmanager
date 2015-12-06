class RemovePriorityIdFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :priority_id, :integer
  end
end
