class AddStateToSubtasks < ActiveRecord::Migration
  def change
    add_column :subtasks, :state, :string
  end
end
