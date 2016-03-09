class Vote < ActiveRecord::Base
  validates :user_id, presence: true
  validates :petition_id, presence: true
  validates_uniqueness_of :petition_id, scope: :user_id
  belongs_to :petition
end
