require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get new" do
    @request.session[:user_id] = nil

    get :new
    assert_response :success
    assert_template :new

    assert_nil @request.session[:user_id]
  end

  test "should redirect when get new if session has user_id" do
    @request.session[:user_id] = @user.id

    get :new
    assert_redirected_to user_topics_path(@user)

    assert_equal @user.id, @request.session[:user_id]
  end

  test "should create session with valid email and password" do
    @request.session[:user_id] = nil

    post :create, email: @user.email, password: "password"
    assert_redirected_to user_topics_path(@user)

    assert_equal @user.id, @request.session[:user_id]
  end

  test "should not create session with invalid email" do
    @request.session[:user_id] = nil

    post :create, email: "another email", passowrd: "password"

    assert_response :success
    assert_template :new

    assert_nil @request.session[:user_id]
  end

  test "should not create session with invalid password" do
    @request.session[:user_id] = nil

    post :create, email: @user.email, passowrd: "another password"

    assert_response :success
    assert_template :new

    assert_nil @request.session[:user_id]
  end

  test "should clear session when get destroy" do
    @request.session[:user_id] = @user.id

    assert_no_difference("User.count") do
      delete :destroy
    end

    assert_redirected_to root_path

    assert_nil @request.session[:user_id]
  end
end
