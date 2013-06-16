require 'test_helper'

class DailylogsControllerTest < ActionController::TestCase
  setup do
    @dailylog = dailylogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dailylogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dailylog" do
    assert_difference('Dailylog.count') do
      post :create, dailylog: { logged_on: @dailylog.logged_on, memo: @dailylog.memo, score: @dailylog.score, topic_id: @dailylog.topic_id }
    end

    assert_redirected_to dailylog_path(assigns(:dailylog))
  end

  test "should show dailylog" do
    get :show, id: @dailylog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dailylog
    assert_response :success
  end

  test "should update dailylog" do
    patch :update, id: @dailylog, dailylog: { logged_on: @dailylog.logged_on, memo: @dailylog.memo, score: @dailylog.score, topic_id: @dailylog.topic_id }
    assert_redirected_to dailylog_path(assigns(:dailylog))
  end

  test "should destroy dailylog" do
    assert_difference('Dailylog.count', -1) do
      delete :destroy, id: @dailylog
    end

    assert_redirected_to dailylogs_path
  end
end
