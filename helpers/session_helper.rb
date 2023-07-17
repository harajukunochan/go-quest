module SessionHelper
  def get_session
    @session ||= Token.find_by(value: get_token)
    # @user ||= @session.user
    # @session
  end

  def current_user
    get_session
    @current_user ||= @session.user unless @session.nil?
  end

  def is_auth?(user)
    current_user == user
  end

  private

  def get_token
    cookies.signed.permanent[:token]
  end
end
