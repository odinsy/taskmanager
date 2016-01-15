class RemoveParentFromTasks < ActiveRecord::Migration
  def change
    remove_reference :tasks, :parent, index: true
  end
end
