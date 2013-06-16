require 'test_helper'

class DailylogsHelperTest < ActionView::TestCase
  tests :dailylogs_helper

  test "badge_class when 1.0" do
    assert_equal "badge badge-important", badge_class(1.0)
  end

  test "badge_class when 0.51" do
    assert_equal "badge badge-important", badge_class(0.51)
  end

  test "badge_class when 0.5" do
    assert_equal "badge", badge_class(0.5)
  end

  test "badge_class when 0" do
    assert_equal "badge", badge_class(0)
  end

  test "badge_class when -0.5" do
    assert_equal "badge", badge_class(-0.5)
  end

  test "badge_class when -0.51" do
    assert_equal "badge badge-info", badge_class(-0.51)
  end

  test "badge_class when -1.0" do
    assert_equal "badge badge-info", badge_class(-1.0)
  end
end
