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

  test "should get new" do
    get :new, topic_id: @topic
    assert_response :success
    assert_template :new
    assert_nil assigns(:dailylog).logged_on
  end

  test "should not get new with invalid combination of user and topic" do
    another_user = users(:two)
    @request.session[:user_id] = another_user.id

    assert_raise(ActiveRecord::RecordNotFound) do
      get :new, topic_id: @topic
    end
  end

  test "should get new with logged_on" do
    get :new, topic_id: @topic, logged_on: "2013-01-01"
    assert_response :success
    assert_template :new
    assert_equal Date.new(2013, 1, 1), assigns(:dailylog).logged_on
  end

  test "should get edit" do
    get :edit, topic_id: @topic, id: @dailylog
    assert_response :success
    assert_template :edit
    assert_not_nil assigns(:dailylog)
  end

  test "should not get edit with invalid combination of user and topic" do
    another_user = users(:two)
    @request.session[:user_id] = another_user.id

    assert_raise(ActiveRecord::RecordNotFound) do
      get :edit, topic_id: @topic, id: @dailylog
    end
  end

  test "should create" do
    assert_difference("Dailylog.count", 1) do
      assert_difference("@topic.dailylogs.size", 1) do
        post :create, topic_id: @topic, dailylog: {logged_on: "2013-01-01", score: 1, memo: nil}
      end
    end

    assert_redirected_to user_topic_dailylogs_path(@user, @topic)
  end

  test "should not create with invalid params" do
    assert_no_difference("Dailylog.count") do
      assert_no_difference("@topic.dailylogs.size") do
        post :create, topic_id: @topic, dailylog: {logged_on: nil, score: 1, memo: nil}
      end
    end

    assert_response :success
    assert_template :new
  end

  test "should update" do
    assert_no_difference("Dailylog.count") do
      assert_no_difference("@topic.dailylogs.size") do
        patch :update, topic_id: @topic, id: @dailylog, dailylog: {logged_on: "2013-01-01", score: 1, memo: nil}
      end
    end

    @dailylog.reload
    assert_equal Date.new(2013, 1, 1), @dailylog.logged_on

    assert_redirected_to user_topic_dailylogs_path(@user, @topic)
  end

  test "should not update" do
    assert_no_difference("Dailylog.count") do
      assert_no_difference("@topic.dailylogs.size") do
        patch :update, topic_id: @topic, id: @dailylog, dailylog: {logged_on: nil, score: 1, memo: nil}
      end
    end

    @dailylog.reload
    assert_not_nil @dailylog.logged_on

    assert_response :success
    assert_template :edit
  end
end
