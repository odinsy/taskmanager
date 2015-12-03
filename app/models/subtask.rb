class Subtask < ActiveRecord::Base

  include AASM
  include ChangeState

  belongs_to  :user
  belongs_to  :task

  validates :title, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true
  validates :task_id, presence: true

end
