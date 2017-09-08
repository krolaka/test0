class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :destroy, :update]

  def index
  end

  def list
    @users = User.all.where.not(id: current_user.id)
  end

  def show
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.assign_attributes(user_params)
    if @user.valid? && @user.save
      redirect_to users_path, notice: 'Profile was successfully created'
    else
      redirect_to new_user_path, alert: 'Something went wrong!'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Delete success."
  end

  def update
    @user.assign_attributes(user_params)
    if @user.valid? && @user.save
      redirect_to users_path, notice: 'Profile was successfully edited'
    else
      redirect_to edit_user(@user.id), alert: 'Something went wrong!'
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :about, :admin, :blocked, :password, :password_confirmation)
  end

end
