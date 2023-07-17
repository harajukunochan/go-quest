class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ show edit update destroy ]

  def index
    @title = "Квесты"
    @quests = Quest.where(public: true)
  end

  def show
    @title = @quest.title

    unless @quest.public or helpers.is_auth? @quest.user
      redirect_back fallback_location: quests_url, status: :forbidden
    end

    @elements = []

    points = QuestPoint.where(quest: @quest, section: nil).order(order: :asc).to_a()
    sections = Section.where(quest: @quest)

    sections_with_points = []
    sections.each do |section|
      section_points = QuestPoint.where(section: section).order(order: :asc)

      sections_with_points << {section: section, points: section_points}
    end

    @elements.push(*points, *sections_with_points)

    @elements.sort_by! do |elem|
      if elem.kind_of?(Hash)
        elem[:section].order
      else
        elem.order
      end
    end

  end

  def new
    @title = "Создать квест"
    redirect_to login_url unless @current_user

    @quest = Quest.new
  end

  def edit
    @title = @quest.title
    redirect_to login_url unless helpers.is_auth? @quest.user
  end

  def create
    redirect_to login_url unless @current_user

    @quest = Quest.new(quest_params_for_create)
    @quest.date = Date.today
    @quest.user = @current_user

    if @quest.save
      helpers.add_notification :alert, "Quest created"
      redirect_to @quest
    else
      if @quest.errors.empty?
        helpers.add_notification :error, "Quest not created", true
      else
        @quest.errors.full_messages.each do |m|
          helpers.add_notification :error, m, true
        end
      end

      render :new, status: :bad_request
    end
  end

  def update
    redirect_to login_url unless helpers.is_auth? @quest.user

    if @quest.update(quest_params)
      helpers.add_notification :alert, "Quest updated", true
      redirect_to @quest
    else
      helpers.add_notification :error, "Quest not updated", true
    end
  end

  def destroy
    if helpers.is_auth? @quest.user
      @quest.destroy
      helpers.add_notification :alert, "Quest deleted", true
      redirect_to @current_user
    end
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params_for_create
    params.require(:quest).permit(:title, :description, :image)
  end

  def quest_params
    params.require(:quest).permit(:title, :description, :image, :public)
  end
end
