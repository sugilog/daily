require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)

    @valid_attributes = {
      name: "user3",
      email: "user3@gmail.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  test "should create" do
    user = User.new(@valid_attributes)
    assert_difference("User.count", 1) do
      assert user.save
    end
  end

  test "should not create unless name is present" do
    user = User.new(@valid_attributes.merge(name: nil))
    assert_no_difference("User.count") do
      assert !user.save
      assert user.errors[:name].any?
    end
  end

  test "should not create unless email is present" do
    user = User.new(@valid_attributes.merge(email: nil))
    assert_no_difference("User.count") do
      assert !user.save
      assert user.errors[:email].any?
    end
  end

  test "should not create unless email is uniqueness" do
    user = User.new(@valid_attributes.merge(email: @user.email))
    assert_no_difference("User.count") do
      assert !user.save
      assert user.errors[:email].any?
    end
  end

  test "should not create unless password is present" do
    user = User.new(@valid_attributes.merge(password: nil, password_confirmation: nil))
    assert_no_difference("User.count") do
      assert !user.save
      assert user.errors[:password].any?
    end
  end

  test "should not create unless password is confirmed" do
    user = User.new(@valid_attributes.merge(password_confirmation: "another password"))
    assert_no_difference("User.count") do
      assert !user.save
      assert user.errors[:password_confirmation].any?
    end
  end

  test "should authenticate with valid password" do
    user = User.create!(@valid_attributes)
    assert user.authenticate(@valid_attributes[:password])
  end

  test "should authenticate with invalid password" do
    user = User.create!(@valid_attributes)
    assert !user.authenticate("another password")
  end
end
