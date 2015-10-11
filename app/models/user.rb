class User < ActiveRecord::Base

  authenticates_with_sorcery!

  has_many :projects, inverse_of: :user
  has_many :tasks, inverse_of: :user

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: 3..15
  validates :password, presence: true, confirmation: true, length: { minimum: 3 }

end
