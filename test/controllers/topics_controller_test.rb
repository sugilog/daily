require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @topic = topics(:one)
    @request.session[:user_id] = @user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal 2, assigns(:topics).size
    assert assigns(:topics).all?{|topic| topic.user_id == @user.id }
  end

  test "should get topics on index with user id related records" do
    another_user = users(:two)
    another_user.topics.create(title: 'title')
    @request.session[:user_id] = another_user.id

    get :index
    assert_equal 1, assigns(:topics).size
    assert assigns(:topics).all?{|topic| topic.user_id == another_user.id }
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should set user_id on get new" do
    get :new
    assert_response :success
    assert assigns(:topic).new_record?
    assert_equal @user.id, assigns(:topic).user_id
  end

  test "should create topic" do
    assert_difference('Topic.count', 1) do
      post :create, topic: { description: @topic.description, title: @topic.title }
    end

    assert_redirected_to user_topics_path(@user)
  end

  test "should not create topic with invalid params" do
    assert_no_difference('Topic.count') do
      post :create, topic: { description: @topic.description, title: nil }
    end

    assert_response :success
    assert_template :new
  end

  test "should ignore user_id on create topic" do
    another_user = users(:two)

    assert_difference('Topic.count', 1) do
      post :create, topic: { description: @topic.description, title: @topic.title, user_id: another_user.id }
    end

    assert_redirected_to user_topics_path(@user)

    assert_not_equal another_user.id, Topic.last.user_id
    assert_equal @user.id, Topic.last.user_id end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should not get topic on get edit with invalid conmbination of user_id and topic_id" do
    another_user = users(:two)
    @request.session[:user_id] = another_user.id

    assert_raise(ActiveRecord::RecordNotFound) do
      get :edit, id: @topic
    end
  end

  test "should update topic" do
    assert_no_difference("Topic.count") do
      patch :update, id: @topic, topic: { description: @topic.description, title: @topic.title }
    end

    assert_redirected_to user_topics_path(@user)
  end

  test "should ignore user_id on update topic" do
    another_user = users(:two)

    assert_no_difference("Topic.count") do
      patch :update, id: @topic, topic: { description: @topic.description, title: @topic.title, user_id: another_user.id }
    end

    assert_redirected_to user_topics_path(@user)
    @topic.reload
    assert_not_equal another_user.id, @topic.user_id
    assert_equal @user.id, @topic.user_id
  end

  test "should not update topic with invalid params" do
    assert_no_difference("Topic.count") do
      patch :update, id: @topic, topic: { description: @topic.description, title: nil }
    end

    assert_response :success
    @topic.reload
    assert_not_nil @topic.title
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to user_topics_path(@user)
  end

  test "should not destroy topic with invalid conmbination of user_id and topic_id" do
    another_user = users(:two)
    @request.session[:user_id] = another_user.id

    assert_no_difference('Topic.count') do
      assert_raise(ActiveRecord::RecordNotFound) do
        delete :destroy, id: @topic
      end
    end
  end
end
