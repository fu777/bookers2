class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @users = current_user
    unless current_user.id == @user.user_id
      redirect_to user_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user info successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
end

  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    user = User.find(params[:id])
    redirect_to user_path if current_user != user
  end
