class User < ActiveRecord::Base
  has_many :topics

  has_secure_password
  validates :email, :name, presence: true
  validates :email, uniqueness: true
end
