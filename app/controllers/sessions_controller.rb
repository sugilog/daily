class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_topics_path(current_user)
    end
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_topics_path(user), notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
