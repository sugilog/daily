class DailylogsController < ApplicationController
  before_action :login_user?
  before_action :set_topic
  before_action :set_dailylog, only: [:edit, :update, :destroy]

  def index
    @dailylogs = @topic.dailylogs
  end

  def new
    @dailylog = @topic.dailylogs.new
  end

  def edit
  end

  def create
    @dailylog = @topic.dailylogs.new(dailylog_params)

    if @dailylog.save
      redirect_to user_topic_dailylogs(current_user, @topic), notice: 'Dailylog was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @dailylog.update(dailylog_params)
      redirect_to user_topic_dailylogs(current_user, @topic), notice: 'Dailylog was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_topic
    @topic = current_user.topics.find(params[:topic_id])
  end

  def set_dailylog
    @dailylog = @topic.dailylogs.find(params[:id])
  end

  def dailylog_params
    params.require(:dailylog).permit(:logged_on, :score, :memo)
  end
end
