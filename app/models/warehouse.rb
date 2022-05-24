class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :adress, :zip_code, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: {is: 3}
  validates :zip_code, format: { with: /\A\d{5}-\d{3}\z/}


def full_description
  "#{code} - #{name}"
end

end