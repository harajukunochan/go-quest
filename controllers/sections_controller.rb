class SectionsController < ApplicationController
  before_action :set
  before_action :verify, only: %i[ new create update destroy ]
  before_action :auth?, only: %i[ new create update destroy ]

  def new
    @section = Section.new

    format.html { render "form.html.erb", :layout => false  }
  end

  def create
    @section = Section.new(section_params)
    @section.quest = @quest

    if @section.save
      # TODO ok html
      format.html { render "form.html.erb", :layout => false  }
    else
      # TODO errors html
      @errors = @section.errors.full_messages
      format.html { render "form.html.erb", :layout => false  }
    end
  end

  def edit
    # TODO
    format.html { render "form.html.erb", :layout => false  }
  end

  def update
    # TODO
    if @section.update(section_params)
      helpers.add_notification :alert, "Section updated", true
    else
      helpers.add_notification :error, "Section not updated", true
    end
  end

  def destroy
    # TODO
    @section.destroy
    helpers.add_notification :alert, "Section deleted", true
  end

  private

  def set
    @quest = Quest.find(params[:quest_id])
    @section = Section.find(params[:id]) if params[:id]
  end

  def verify
    if @section
      redirect_to root_url, status: :bad_request unless @quest == @section.quest
    end
  end

  def auth?
    redirect_to login_url, status: :unauthorized unless @current_user == @quest.user
  end

  def section_params
    params.require(:section).permit(:title, :order, :description)
  end
end
