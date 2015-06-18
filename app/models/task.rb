class Task < ActiveRecord::Base
  has_many    :subtasks, class_name: 'Task'
  belongs_to  :parent, class_name: 'Task'
  belongs_to  :user
  belongs_to  :project
end
