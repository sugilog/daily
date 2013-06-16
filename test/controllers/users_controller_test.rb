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

  test "should not destroy user without session" do
    @request.session[:user_id] = nil

    assert_no_difference('User.count') do
      delete :destroy
    end

    assert_redirected_to root_path
  end

  test "get edit_password" do
    @request.session[:user_id] = @user.id

    get :edit_password, id: @user

    assert_response :success
    assert_template :edit_password
  end

  test "get edit_password without session" do
    @request.session[:user_id] = nil
    get :edit_password, id: @user

    assert_redirected_to root_path
  end

  test "update password" do
    @request.session[:user_id] = @user.id

    patch :update_password, id: @user, user: {password: "123", password_confirmation: "123"}
    assert_redirected_to user_path(@user)
    @user.reload
    assert @user.authenticate("123")
  end

  test "update password ignore another params" do
    @request.session[:user_id] = @user.id

    patch :update_password, id: @user, user: {password: "123", password_confirmation: "123", name: "hoge"}
    assert_redirected_to user_path(@user)
    @user.reload
    assert_not_equal "hoge", @user.name
  end

  test "update password with invalid password" do
    @request.session[:user_id] = @user.id

    patch :update_password, id: @user, user: {password: "123", password_confirmation: "456"}
    assert_response :success
    assert_template :edit_password
    assert @user.authenticate("password")
  end
end
