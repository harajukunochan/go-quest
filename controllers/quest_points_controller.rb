class QuestPointsController < ApplicationController
  before_action :set
  before_action :verify, only: %i[ new create update destroy ]
  before_action :auth?, only: %i[ new create update destroy ]
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def show
    @title = @point.title
    @content = JSON.parse(@point.content);
  end

  def new
    @point = QuestPoint.new
    @title = "Новый пункт"
  end

  def edit
    @title = @point.title
  end

  def create
    @point = QuestPoint.new(point_params)
    @point.quest = @quest
    @point.order = 10

    if @point.save
      helpers.add_notification :alert, "Point created"
      redirect_to quest_quest_point_url(@quest, @point)
    else
      if @point.errors.empty?
        helpers.add_notification :error, "Point not created", true
      else
        @point.errors.full_messages.each do |m|
          helpers.add_notification :error, m, true
        end
      end
      render :new, status: :bad_request
    end
  end

  def update
    @title = @point.title
    if @point.update(point_params)
      helpers.add_notification :alert, "Point updated", true
      redirect_to @point
    else
      helpers.add_notification :error, "Point not updated", true
    end
  end

  def destroy
    @point.destroy
    helpers.add_notification :alert, "Point deleted", true
    redirect_to @quest
  end

  def get_image
    filename = "#{params[:filename]}.#{params[:format]}"
    @point.images.each do |image|
      if image.filename == filename
        render plain: image.url
      end
    end
  end

  private

  def set
    @quest = Quest.find(params[:quest_id])
    @point = QuestPoint.find(params[:id]) if params.key?(:id)
    @point = QuestPoint.find(params[:quest_point_id]) if params.key?(:quest_point_id)
  end

  def verify
    if @point
      redirect_to root_url, status: :bad_request unless @quest == @point.quest
    end
  end

  def auth?
    redirect_to login_url, status: :unauthorized unless @current_user == @quest.user
  end

  def point_params
    params.require(:quest_point).permit(:title, :description, :order, :section, :content, :images => [])
  end
end
