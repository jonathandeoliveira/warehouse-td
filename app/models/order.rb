class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :product_models, through: :order_items

  enum status: {pending: 0, delivered:10, canceled:20}

  validates :deadline_delivery, :code, presence:true
  validate :estimated_delivery_date_is_future




  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_is_future
    if self.deadline_delivery.present? && self.deadline_delivery <= Date.today
      self.errors.add(:deadline_delivery, 'deve ser futura')
    end
  end


end
