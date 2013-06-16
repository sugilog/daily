class Dailylog < ActiveRecord::Base
  belongs_to :topic
  validates :logged_on, presence: true, uniqueness: {scope: [:topic_id]}

  def self.monthly(topic, start_date = Date.today)
    from = start_date.beginning_of_month
    to   = start_date.end_of_month

    dailylogs = topic.dailylogs.where(["logged_on BETWEEN :from AND :to", {from: from, to: to}])

    (from..to).inject(ActiveSupport::OrderedHash[]){|container, date|
      dailylog =
        dailylogs.detect{|log| log.logged_on == date } ||
        topic.dailylogs.new(logged_on: date)

      container.update(date => dailylog)
    }
  end
end
