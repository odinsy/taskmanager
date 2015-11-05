class Subtask < ActiveRecord::Base

  include AASM

  aasm :column => 'state' do
    state :active, :initial => true
    state :completed
    event :run do
      transitions :from => :completed, :to => :active
    end
    event :complete do
      transitions :from => :active, :to => :completed
    end
  end

  belongs_to  :user
  belongs_to  :task

  validates :title, presence: true, length: { minimum: 1 }
  validates :user_id, presence: true
  validates :task_id, presence: true

end
