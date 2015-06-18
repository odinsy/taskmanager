class Project < ActiveRecord::Base
  has_many    :tasks
  has_many    :subtasks, through: :tasks
  belongs_to  :user
end
