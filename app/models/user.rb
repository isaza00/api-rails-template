class User < ApplicationRecord
  has_secure_password
  #has_many :something, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
            length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false },
            allow_nil: false, on: :create
  validates :email, presence: true,
            length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false },
            allow_nil: true, on: :update
  validates :password, presence: true,
            length: { minimum: 4, maximum: 255 },
            allow_nil: false, on: :create
  validates :password, presence: true,
            length: { minimum: 4, maximum: 255 },
            allow_nil: true, on: :update
  validates :name, presence: true,
            length: { minimum: 3, maximum: 255 },
            allow_nil: true, on: :create
  validates :name, presence: true,
            length: { minimum: 3, maximum: 255 },
            allow_nil: true, on: :update

end
