class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  validates :name,:sku, :weight,:width,:height, :depth,:supplier_id, presence: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
  validates :sku, uniqueness: true
end
