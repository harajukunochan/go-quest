class SessionController < ApplicationController
  def new
    @title = "Вход"
    redirect_to user_url(@current_user) unless @current_user.nil?
    create unless cookies.signed.encrypted[:login_token].nil?
  end

  def create
    unless cookies.signed.encrypted[:login_token].nil?
      token = JSON.parse(cookies.signed.encrypted[:login_token])
      name = token["name"]
      password = token["password"]

      cookies.delete :login_token
    else
      name = params[:session][:name]
      password = params[:session][:password]
    end

    @user = User.find_by(name: name)

    if @user && @user.authenticate(password)
      begin
        @session.destroy unless @session.nil?
        set_session create_token @user
      rescue Exception => e
        helpers.add_notification :error, e.message, true
      end

      redirect_to @user
    else
      helpers.add_notification :danger, 'Invalid name/password combination', true
      render 'new', status: :bad_request
    end
  end

  def destroy
    @session.destroy unless @session.nil?
    cookies.delete :token
    redirect_to root_path
  end

  private

  def set_session(token)
    cookies.signed.permanent[:token] = token.value
    @session = token
  end

  def create_token(user)
    browser = Browser.new(request.env['HTTP_USER_AGENT'], accept_language: "en-us")

    token = Token.new
    token.user = user
    token.value = "#{@name}-#{SecureRandom.uuid}"
    token.browser = browser.name
    token.platform = browser.platform.name

    unless token.save
      raise "Token not saved"
    end

    token
  end
end
