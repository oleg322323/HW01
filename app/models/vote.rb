class Vote < ActiveRecord::Base
  validates :user_id, presence: true
  validates :petition_id, presence: true
  validates_uniqueness_of :user_id, scope: :petition_id

  validate :expire_date

  belongs_to :petition
  belongs_to :user

  def expire_date
    if petition.expired?
      errors.add(:expire_date, 'петиция просрочена')
    end
  end
end
