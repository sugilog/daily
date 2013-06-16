require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @topic = topics(:one)

    @valid_attributes = {
      user_id:     @user.id,
      title:       "title",
      description: "description"
    }
  end

  test "should create" do
    topic = Topic.new(@valid_attributes)
    assert_difference("Topic.count", 1) do
      assert topic.save
    end
  end

  test "should not create unless logged_on is present" do
    topic = Topic.new(@valid_attributes.merge(title: nil))
    assert_no_difference("Topic.count") do
      assert !topic.save
      assert topic.errors[:title].any?
    end
  end
end
