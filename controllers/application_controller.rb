class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user = helpers.current_user
  end
end
