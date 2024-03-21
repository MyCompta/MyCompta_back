class UsersController < ApplicationController

  before_action :authenticate_user!

  # def index
  #   @users = User.all

  #   render json:@users
  # end

  def show
    if user_signed_in? && @user = current_user
    @user = User.find(params[:id])
      render json: @user
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def destroy
  if @user = current_user
    @user.destroy
      render json: {message: 'destroy successful'}
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

end