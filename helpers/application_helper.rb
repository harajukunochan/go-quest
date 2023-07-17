module ApplicationHelper
  def add_notification(type, message, now = false)
    if now
      p type, message
      flash.now[type] ||= []
      flash.now[type] << message
    else
      flash[type] ||= []
      flash[type] << message
    end
  end

  def title
    if @title.blank?
      "go quest"
    else
      @title.strip + " | go quest"
    end
  end
end
