class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name,:sku, :weight,:width,:height, :depth,:supplier_id, presence: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
  validates :sku, uniqueness: true
end
