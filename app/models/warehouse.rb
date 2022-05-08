class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :adress, :zip_code, :area, presence: true
  validates :code, uniqueness: true
  #validates :code, length: {is: 3 }
  #validates :zip_code, length: {is: 9 }
end