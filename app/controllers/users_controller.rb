class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    render json: @users, status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: 'Utente creato con successo.'
      return 
    else
      render :new
    end
    render json: @users, status: 200
  end

  def update
    unless @user.update(user_params)
      render json: {errors: @user.errors.full_messages}, status: 503
    end
  end

  def destroy
    @user.destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :surname, :username, :email, :password, :date_of_birth)
    end

    def find_user
      @user = User.find(params[:id])
    end
end