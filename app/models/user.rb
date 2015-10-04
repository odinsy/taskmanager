class User < ActiveRecord::Base

  authenticates_with_sorcery!

  has_many :projects
  has_many :tasks

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: 3..15
  validates :password, presence: true, confirmation: true, length: { minimum: 3 }

end
