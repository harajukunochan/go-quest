class PagesController < ApplicationController
  def main
    @title = "Главная"
    unless @current_user.nil?
      @user = @current_user
      render "users/show"
    end
  end

  def faq
    @title = "FAQ"
  end

  def contact
    @title = "Кто мы"
  end
end
