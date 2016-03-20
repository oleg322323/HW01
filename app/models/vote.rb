class Vote < ActiveRecord::Base
  validates :user_id, presence: true
  validates :petition_id, presence: true
  validates_uniqueness_of :user_id, scope: :petition_id

  validate :expire_date #кастомная валидация (НЕ ПРОВЕРЯЛ)

  belongs_to :petition
  belongs_to :user

  def expire_date
    unless petition.expired?
      errors.add(:expiration_date, 'петиция просрочена')
    end
  end
end
