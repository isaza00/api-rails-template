class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorized, only: [:show, :index, :update, :destroy]
  before_action :correct_user, only: [:show, :update, :destroy]
  before_action :isadmin?, only: [:index]


  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token({user_id: user.id})
      render json: {user: user, token: token}, status: :ok
    else
      render json: { errors: "Invalid username or password" }, status: :unauthorized #401
    end
  end

  # GET /users
  def index
    users = User.all
    render json: { users: users }, status: :ok
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      token = encode_token({user_id: user.id})
      render json: {user: user, token: token}, status: :created
    else
      render json: { errors: user.errors.messages }, status: 422
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      render json: { user: @user }, status: 204
    else
      render json: { errors: @user.errors.messages }, status: 422
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue => e
        render json: { errors: e.message}, status: 404
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :email, :password)
    end
end
