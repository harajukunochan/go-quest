class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy quests ]

  # GET /users
  def index
    @title = "Пользователи"
    @users = User.all
  end

  # GET /users/1
  def show
    @title = @user.name
    @quests = Quest.where(user: @user)
    unless helpers.is_auth? @user
      @quests = @quests.select {|q| q.public }
    end

  end

  # GET /users/new
  def new
    @title = "Регистрация"
    redirect_to register_url if request.fullpath != "/register"
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @title = "Настройки"
    unless helpers.is_auth? @user
      redirect_to login_url, status: :unauthorized
    end
  end

  # POST /users
  def create
    @user = User.new(user_params_for_register)

    if @user.save
      cookies.signed.encrypted[:login_token] = JSON.generate({ name: params["user"]["name"], password: params["user"]["password"] })
      helpers.add_notification :alert, "User created"
      redirect_to login_url
    else
      if @user.errors.empty?
        helpers.add_notification :error, "User not created", true
      else
        @user.errors.full_messages.each do |m|
          helpers.add_notification :error, m, true
        end
      end

      render :new, status: :bad_request
    end
  end

  # PATCH/PUT /users/1
  def update
    unless helpers.is_auth? @user
      redirect_to login_url
    end

    if @user.update(user_params)
      helpers.add_notification :alert, "User updated", true
      redirect_to @user
    else
      helpers.add_notification :error, "User not updated", true
    end
  end

  # DELETE /users/1
  def destroy
    if helpers.is_auth? @user
      @user.destroy
      helpers.add_notification :alert, "User deleted", true
      redirect_to :users
    end
  end

  # GET /user
  def current
    if @session = helpers.get_session
      redirect_to @session.user
    else
      redirect_to login_url
    end
  end

  # GET /user/1/quests
  def quests
    @title = @user.name
    @quests = Quest.where(user: @user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params_for_register
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :avatar, :description, :admin)
    end
end
