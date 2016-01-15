class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string  :title, null: false
      t.integer :user_id
      t.integer :task_id

      t.timestamps null: false
    end

    add_index :subtasks, :task_id
    add_index :subtasks, :user_id
  end
end
