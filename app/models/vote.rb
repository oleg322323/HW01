class Vote < ActiveRecord::Base
  validates :user_id, presence: true
  validates :petition_id, presence: true
  validates_uniqueness_of :user_id, scope: :petition_id
  belongs_to :petition
end
