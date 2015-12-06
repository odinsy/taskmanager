class Task < ActiveRecord::Base

  include AASM
  include ChangeState

  #default_value_for :priority, 0

  belongs_to  :user
  belongs_to  :project
  belongs_to  :priority
  has_many    :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, length: { minimum: 3 }
  validates :priority_id, presence: true
  validates :user_id, presence: true

  scope :today, -> { where("scheduled <= ?", Date.today) }
  scope :tomorrow, -> { where("scheduled == ?", Date.today + 1) }
  scope :scheduled, -> { where("scheduled > ?", Date.today + 1) }
  scope :waiting, -> { where("scheduled IS ?", nil) }
  scope :completed, -> { where(state: "completed") }

end
