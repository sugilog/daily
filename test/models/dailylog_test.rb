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
end
