class VotesController < ApplicationController
  before_filter :authorize, only: [:create]

  def create
    vote = Vote.new(vote_params, user_id: current_user.id.to_s) #создаваться должен после условия, починить
    if false #vote.user_id == current_user.id  #за свои голосовать нельзя
      redirect_to :back, alert: "Ошибка доступа"
    else
      vote.save ? flash.notice = "Голос засчитан" : flash.alert = "Вы уже голосовали"
      redirect_to :back
    end
  end

  def vote_params
    params.require(:vote).permit(:petition_id)
  end
end
