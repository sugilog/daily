class Dailylog < ActiveRecord::Base
  belongs_to :topic
  validates :logged_on, presence: true, :uniqueness: {scope: [:topic_id]}
end
