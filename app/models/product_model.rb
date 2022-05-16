class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name,:sku, :weight, presence: true
end
