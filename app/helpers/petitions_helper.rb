module PetitionsHelper
  def time_left
    distance_of_time_in_words(@petition.created_at, @petition.class::DAYS_TO_CHECK.days.ago, :locale => :en)
  end
end
