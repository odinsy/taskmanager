class Project < ActiveRecord::Base

  belongs_to  :user
  has_many    :tasks

  accepts_nested_attributes_for :tasks, allow_destroy: true

  validates :title, presence: true, length: { minimum: 3 }

end
