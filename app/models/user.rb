class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :username, type: String
  field :password_digest, type: String

  has_secure_password

  has_many :orders
  has_many :carts

  index({ username: 1 }, { unique: true })

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  ADMIN_NAME = 'admin'

  def admin?
    username == ADMIN_NAME
  end
end
