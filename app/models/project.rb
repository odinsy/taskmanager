class Project < ActiveRecord::Base

  include AASM
  include ChangeState

  belongs_to  :user
  has_many    :tasks
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true, limit: 1

  validates :title, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true

end
