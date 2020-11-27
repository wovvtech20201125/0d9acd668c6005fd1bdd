class Api::UsersController < ApplicationController

  before_action :get_user, :only => [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      render json: @user and return
    else
      render json: {:error => @user.errors} and return
    end
  end

  def update
    begin
      @user.update_attributes(user_params)
      render json: @user.reload
    rescue
      render json: {error: @user.errors} and return
    end
  end

  def destroy
    begin
      @user.destroy
      render json: {success: "Record succesfully destroyed"}
    rescue
      render json: {error: @user.errors} and return
    end
  end

  def search
    search = User.search { fulltext params[:input] }
    if search.results.present?
      render json: search.results and return
    else
      render json: {:results => "No match found"} and return
    end
  end

  private

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email)
  end
end