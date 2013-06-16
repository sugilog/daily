require 'test_helper'

class DailylogTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @topic = topics(:one)
    @dailylog = dailylogs(:one)

    @valid_attributes = {
      topic_id:  @topic.id,
      logged_on: Date.yesterday,
      score:     12.3,
      memo:      "test"
    }
  end

  test "should create" do
    dailylog = Dailylog.new(@valid_attributes)
    assert_difference("Dailylog.count", 1) do
      assert dailylog.save
    end
  end

  test "should not create unless logged_on is present" do
    dailylog = Dailylog.new(@valid_attributes.merge(logged_on: nil))
    assert_no_difference("Dailylog.count") do
      assert !dailylog.save
      assert dailylog.errors[:logged_on].any?
    end
  end

  test "should not create unless logged_on is uniqueness in topic" do
    dailylog = Dailylog.new(@valid_attributes.merge(logged_on: @dailylog.logged_on))
    assert_no_difference("Dailylog.count") do
      assert !dailylog.save
      assert dailylog.errors[:logged_on].any?
    end
  end

  test "monthly without start date" do
    dailylogs = Dailylog.monthly(@topic)

    assert_equal Date.today.end_of_month.mday, dailylogs.size

    (Date.today.beginning_of_month..Date.today.end_of_month).each do |date|
      case date
      when Date.today
        assert_equal @dailylog, dailylogs[date]
      when Date.tomorrow
        assert_equal dailylogs(:two), dailylogs[date]
      else
        assert dailylogs[date].new_record?
      end
    end
  end

  test "monthly with start date" do
    dailylogs = Dailylog.monthly(@topic, Date.new(2013, 1, 1))

    assert_equal 31, dailylogs.size

    dailylogs.each do |date, dailylog|
      assert dailylog.new_record?
    end
  end
end
