class Dailylog < ActiveRecord::Base
  belongs_to :topic
  validates :logged_on, presence: true, uniqueness: {scope: [:topic_id]}

  def self.monthly(topic, start_date = Date.today)
    from = start_date.beginning_of_month
    to   = start_date.end_of_month

    dailylogs = topic.dailylogs.where(["logged_on BETWEEN :from AND :to", {from: from, to: to}])
    set_degree(dailylogs)

    (from..to).inject(ActiveSupport::OrderedHash[]){|container, date|
      dailylog =
        dailylogs.detect{|log| log.logged_on == date } ||
        topic.dailylogs.new(logged_on: date)

      container.update(date => dailylog)
    }
  end

  def self.set_degree(dailylogs)
    scores = dailylogs.map(&:score).compact

    if scores.present?
      min = scores.min
      range = scores.max - min

      dailylogs.each do |dailylog|
        if dailylog.score.present?
          dailylog.degree = (2.0 * (dailylog.score - min) / range) - 1
        end
      end
    end
  end

  def degree=(_degree)
    @degree = _degree
  end

  def degree
    @degree || 0
  end
end
