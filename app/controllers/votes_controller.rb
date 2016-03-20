class VotesController < ApplicationController
  before_filter :authorize, only: [:create]

  def create
    if Petition.find(params[:vote][:petition_id]).user_id == current_user.id
      redirect_to :back, alert: 'Ошибка доступа'
    else
      vote = Vote.new(vote_params.merge(user_id: current_user.id.to_s))
      vote.save ? flash.notice = 'Голос засчитан' : flash.alert = vote::errors.messages.map{ |k, v| v[0] }.join(', ')
      redirect_to :back
    end
  end

  def vote_params
    params.require(:vote).permit(:petition_id)
  end
end
