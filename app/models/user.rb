class User < ApplicationRecord
  has_secure_password
  has_many :conversations, foreign_key: :sender_id
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
