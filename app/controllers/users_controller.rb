class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { status: :ok, user: @user }
    else
      render json: { errors: @user.errors, status: :unprocessable_entity }, status: 422
    end
  end

  def update
    if @user.update(user_params)
      render json: {status: :ok, user: @user }
    else
      render json: {errors: @user.errors, status: :unprocessable_entity }, status: 422
    end
  end

  def destroy
    @user.destroy
    render json: { status: :no_content }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :phone_number, :email, properties: {})
    end
end
