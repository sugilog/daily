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
    _dailylogs = Dailylog.monthly(@topic)

    assert_equal Date.today.end_of_month.mday, _dailylogs.size

    (Date.today.beginning_of_month..Date.today.end_of_month).each do |date|
      case date
      when Date.today
        assert_equal @dailylog, _dailylogs[date]
        assert_equal 1, _dailylogs[date].degree
      when Date.tomorrow
        assert_equal dailylogs(:two), _dailylogs[date]
        assert_equal -1, _dailylogs[date].degree
      else
        assert _dailylogs[date].new_record?
        assert _dailylogs[date].degree.zero?
      end
    end
  end

  test "monthly with start date" do
    _dailylogs = Dailylog.monthly(@topic, Date.new(2013, 1, 1))

    assert_equal 31, _dailylogs.size

    _dailylogs.each do |date, dailylog|
      assert dailylog.new_record?
      assert dailylog.degree.zero?
    end
  end

  test "set_degree" do
    _dailylogs = [Dailylog.new(score: 7), Dailylog.new(score: 5), Dailylog.new(score: 15)]
    Dailylog.set_degree(_dailylogs)

    assert_equal -0.6, _dailylogs[0].degree
    assert_equal -1.0, _dailylogs[1].degree
    assert_equal 1.0,  _dailylogs[2].degree
  end

  test "set_degree with score nil" do
    _dailylogs = [Dailylog.new(score: nil), Dailylog.new(score: 5), Dailylog.new(score: 15)]
    Dailylog.set_degree(_dailylogs)

    assert_equal 0,    _dailylogs[0].degree
    assert_equal -1.0, _dailylogs[1].degree
    assert_equal 1.0,  _dailylogs[2].degree
  end

  test "set_degree with all score nil" do
    _dailylogs = [Dailylog.new(score: nil), Dailylog.new(score: nil), Dailylog.new(score: nil)]
    Dailylog.set_degree(_dailylogs)

    assert_equal 0, _dailylogs[0].degree
    assert_equal 0, _dailylogs[1].degree
    assert_equal 0, _dailylogs[2].degree
  end
end
