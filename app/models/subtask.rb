class Subtask < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :task

  validates :title, presence: true, length: { minimum: 1 }
  validates :user_id, presence: true

end
