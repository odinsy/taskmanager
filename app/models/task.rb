class Task < ActiveRecord::Base
  has_many  :subtasks, classname: 'Task', foreign_key: 'parent_id'
  belongs_to  :task, classname: 'Task'
  belongs_to  :user
  belongs_to  :project
end
