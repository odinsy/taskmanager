class Project < ActiveRecord::Base

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
  has_many    :tasks
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true, limit: 1

  validates :title, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true

end
