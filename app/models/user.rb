class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :username, presence: true,
                      uniqueness: { case_sensitive: false },
                      length: { in: 3..25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_many :articles, dependent: :destroy

  has_secure_password
end
