class Petition < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true
  #ассоциации
  belongs_to :user
  has_many :votes
end
