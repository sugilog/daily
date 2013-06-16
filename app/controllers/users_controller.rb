class UsersController < ApplicationController
  before_action :login_user?, only: [:show, :destroy, :change_password, :edit_password, :update_password]

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

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user

    if @user.update_attributes(user_params.permit(:password, :password_confirmation))
      redirect_to @user, notice: "Password was successfully updated."
    else
      render action: :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
