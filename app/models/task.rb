class Task < ActiveRecord::Base

  validates :title, :priority,  presence: true
  validates :title, length: { minimum: 3 }
  validates :priority, numericality: { only_integer: true }, length: { is: 1 }

  has_many    :subtasks, class_name: 'Task', foreign_key: 'parent_id', dependent: :destroy
  belongs_to  :parent, class_name: 'Task'
  accepts_nested_attributes_for :subtasks, allow_destroy: true
  belongs_to  :user
  belongs_to  :project

  scope :main, -> { where("parent_id IS ?", nil) }
  scope :today, -> { where("scheduled <= ?", Date.today) }
  scope :tomorrow, -> { where("scheduled == ?", Date.tomorrow) }
  scope :scheduled, -> { where("scheduled > ?", Date.tomorrow) }
  scope :waiting, -> { where("scheduled IS ?", nil) }

end
