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

  accepts_nested_attributes_for :tasks, allow_destroy: true

  validates :title, presence: true, length: { minimum: 3 }

end
