class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :dailylogs

  validates :title, presence: true
end
