class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :cart_items

  belongs_to :user

  field :status, type: Symbol

  STATUSES = %i[ongoing placed].freeze

  validates :status, inclusion: { in: STATUSES }

  index({ user_id: 1, status: 1 })
end
