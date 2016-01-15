class AddPriorityIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :priority_id, :integer
  end
end
