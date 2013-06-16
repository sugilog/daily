class DailylogsController < ApplicationController
  before_action :login_user?
  before_action :set_topic
  # before_action :set_dailylog, only: [:edit, :update, :destroy]

  def index
    @dailylogs = Dailylog.monthly(@topic, start_date)
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

  def start_date
    @start_date ||=
      if params[:year] && params[:month]
        Date.new(params[:year].to_i, params[:month].to_i)
      else
        Date.today.beginning_of_month
      end
  end

  helper_method :start_date
end
