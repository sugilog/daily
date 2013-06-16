require 'test_helper'

class DailylogsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @topic = topics(:one)
    @dailylog = dailylogs(:one)
    @request.session[:user_id] = @user.id
  end

  test "should get index" do
    get :index, topic_id: @topic
    assert_response :success
    assert_not_nil assigns(:topic)
    assert_not_nil assigns(:dailylogs)
  end

  test "should get index with invalid conmbination of user and topic" do
    another_user = users(:two)
    @request.session[:user_id] = another_user.id

    assert_raise(ActiveRecord::RecordNotFound) do
      get :index, topic_id: @topic
    end
  end

  test "should get index without session" do
    @request.session[:user_id] = nil
    get :index, topic_id: @topic
    assert_redirected_to root_path
  end

  test "should get index without topic_id" do
    assert_raise(ActiveRecord::RecordNotFound) do
      get :index
    end
  end
end
