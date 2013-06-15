require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "user3@gmail.com", name: "user3", password: "password", password_confirmation: "password" }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should create with invalid params" do
    assert_no_difference('User.count') do
      post :create, user: { email: "user3@gmail.com", name: "user3", password_digest: "password" }
    end

    assert_response :success
    assert_template :new

    assert_no_difference('User.count') do
      post :create, user: { email: @user.email, name: "user3", password: "password", password_confirmation: "password" }
    end

    assert_response :success
    assert_template :new
  end

  test "should show user" do
    @request.session[:user_id] = @user.id

    get :show
    assert_response :success
  end

  test "should destroy user" do
    @request.session[:user_id] = @user.id

    assert_difference('User.count', -1) do
      delete :destroy
    end

    assert_redirected_to controller: :sessions, action: :destroy
  end

  test "should not show user unless login" do
    @request.session[:user_id] = nil

    get :show
    assert_redirected_to root_path
  end

  test "should not destroy user unless login" do
    @request.session[:user_id] = nil

    assert_no_difference('User.count') do
      delete :destroy
    end

    assert_redirected_to root_path
  end
end
