class User < ActiveRecord::Base
  has_secure_password

  # attr_accessor :email, :first_name, :last_name, :password, :password_confirmation

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 2 }
  #ассоциации
  has_many :petitions
end
