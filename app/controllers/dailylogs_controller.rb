class DailylogsController < ApplicationController
  before_action :login_user?
  before_action :set_topic
  # before_action :set_dailylog, only: [:edit, :update, :destroy]

  def index
    @dailylogs = @topic.dailylogs
  end

  private

  def set_topic
    @topic = current_user.topics.find(params[:topic_id])
  end

  # def set_dailylog
  #   @dailylog = @topic.dailylogs.find(params[:id])
  # end

  # def dailylog_params
  #   params.require(:dailylog).permit(:logged_on, :score, :memo)
  # end
end
