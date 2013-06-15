class UsersController < ApplicationController
  before_action :login_user?, only: [:show, :destroy]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    current_user.destroy
    redirect_to controller: :sessions, action: :destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
