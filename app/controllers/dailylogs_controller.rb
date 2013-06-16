class DailylogsController < ApplicationController
  before_action :set_dailylog, only: [:show, :edit, :update, :destroy]

  # GET /dailylogs
  # GET /dailylogs.json
  def index
    @dailylogs = Dailylog.all
  end

  # GET /dailylogs/1
  # GET /dailylogs/1.json
  def show
  end

  # GET /dailylogs/new
  def new
    @dailylog = Dailylog.new
  end

  # GET /dailylogs/1/edit
  def edit
  end

  # POST /dailylogs
  # POST /dailylogs.json
  def create
    @dailylog = Dailylog.new(dailylog_params)

    respond_to do |format|
      if @dailylog.save
        format.html { redirect_to @dailylog, notice: 'Dailylog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dailylog }
      else
        format.html { render action: 'new' }
        format.json { render json: @dailylog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dailylogs/1
  # PATCH/PUT /dailylogs/1.json
  def update
    respond_to do |format|
      if @dailylog.update(dailylog_params)
        format.html { redirect_to @dailylog, notice: 'Dailylog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dailylog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dailylogs/1
  # DELETE /dailylogs/1.json
  def destroy
    @dailylog.destroy
    respond_to do |format|
      format.html { redirect_to dailylogs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dailylog
      @dailylog = Dailylog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dailylog_params
      params.require(:dailylog).permit(:logged_on, :score, :memo, :topic_id)
    end
end
