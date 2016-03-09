class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params)
    if vote.save
      flash.now.alert = "Голос засчитан"
    else
      flash.now.alert = "Вы уже голосовали"
    end
    redirect_back(fallback_location: root_path)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :petition_id)
  end
end
