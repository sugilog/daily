class TopicsController < ApplicationController
  before_action :login_user?
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = current_user.topics
  end

  def new
    @topic = current_user.topics.new
  end

  def edit
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to user_topics_path(current_user), notice: 'Topic was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to user_topics_path(current_user), notice: 'Topic was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to user_topics_path(current_user)
  end

  private

  def set_topic
    @topic = current_user.topics.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
