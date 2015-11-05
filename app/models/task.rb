class Task < ActiveRecord::Base

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

  default_value_for :priority, 0

  belongs_to  :user
  belongs_to  :project
  has_many    :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, length: { minimum: 3 }
  validates :priority, presence: true, numericality: { only_integer: true }, length: { is: 1 }
  validates :user_id, presence: true

  scope :today, -> { where("scheduled <= ?", Date.today) }
  scope :tomorrow, -> { where("scheduled == ?", Date.tomorrow) }
  scope :scheduled, -> { where("scheduled > ?", Date.tomorrow) }
  scope :waiting, -> { where("scheduled IS ?", nil) }
  scope :completed, -> { where(state: "completed") }

end
