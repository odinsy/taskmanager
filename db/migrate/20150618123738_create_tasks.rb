class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :title
      t.text    :description
      t.string  :priority
      t.string  :status
      t.date    :scheduled
      t.date    :deadline
      t.integer :parent_id
      t.integer :user_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
