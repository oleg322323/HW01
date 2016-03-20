class Petition < ActiveRecord::Base
  VOTES_MIN = 100
  DAYS_TO_CHECK = 30

  validates :title, presence: true, uniqueness: true
  validates :text, presence: true
  #ассоциации
  belongs_to :user
  has_many :votes

  def text_safe
    text.gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
  end

  def expired?
    created_at < self.class::DAYS_TO_CHECK.days.ago
  end

  def check!
    update_attributes(checked: true)
  end
end
