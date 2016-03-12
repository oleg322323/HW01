class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params)
    if vote.save
      flash.notice = "Голос засчитан"
    else
      flash.alert = "Вы уже голосовали"
    end
    redirect_to :back
  end

  def vote_params
    params.require(:vote).permit(:user_id, :petition_id)
  end
end
