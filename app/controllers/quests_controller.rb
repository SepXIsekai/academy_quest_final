class QuestsController < ApplicationController
  before_action :set_quest, only: %i[destroy toggle_status]

  def index
    @quests = Quest.order(id: :desc)
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)

    if @quest.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to quests_path }
        format.json { render json: @quest, status: :created }
      end
    else
      @quests = Quest.order(id: :desc)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("quest_form", partial: "form", locals: { quest: @quest }) }
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quest.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path, status: :see_other }
      format.json { head :no_content }
    end
  end

  def toggle_status
    @quest.update(status: !@quest.status)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path }
      format.json { render json: @quest, status: :ok }
    end
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:activity)
  end
end
