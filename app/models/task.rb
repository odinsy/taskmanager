class Task < ActiveRecord::Base

  include AASM

  aasm :column => 'status' do
    state :in_work, :initial => true
    state :completed

    event :run do
      transitions :from => :completed, :to => :in_work
    end

    event :complete do
      transitions :from => :in_work, :to => :completed
    end
  end

  validates :title, presence: true, length: { minimum: 3 }
  validates :priority, presence: true, numericality: { only_integer: true }, length: { is: 1 }

  has_many    :subtasks, class_name: 'Task', foreign_key: 'parent_id', dependent: :destroy
  belongs_to  :parent, class_name: 'Task'
  accepts_nested_attributes_for :subtasks, allow_destroy: true
  belongs_to  :user
  belongs_to  :project

  scope :main, -> { where(parent_id: nil) }
  scope :in_work, -> { where(status: "in_work") }
  scope :today, -> { where("scheduled <= ?", Date.today) }
  scope :tomorrow, -> { where("scheduled == ?", Date.tomorrow) }
  scope :scheduled, -> { where("scheduled > ?", Date.tomorrow) }
  scope :waiting, -> { where("scheduled IS ?", nil) }
  scope :completed, -> { where(status: "completed") }

end
