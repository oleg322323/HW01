class VotingEndingJob < ActiveJob::Base
  queue_as :default

  # def perform
  #   p '=========== starting rake'
  #   petition = Petition.first
  #   petition.destroy!
  #   p '=========== destroyed! id: ' + petition.id.to_s
  # end

  def perform
    # UserMailer.petition_created(Petition.last).deliver_later

    Petition.where("created_at < ?", Petition::DAYS_TO_CHECK.days.ago) do |petition| # все просроченые
      unless petition.checked?
        petition.check!
        if petition.votes.count >= petition.class::VOTES_MIN
          UserMailer.petition_complete(petition).deliver_later
          AdminMailer.petition_complete(petition).deliver_later
        else
          UserMailer.petition_fail(petition).deliver_later
        end
      end
    end

  end

end
