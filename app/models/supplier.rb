class Supplier < ApplicationRecord

  validates :company_name, :company_register, :brand_name, :adress, :city,
            :state, :email, :phone_number, presence: true
  validates :company_register, uniqueness: true
  validates :company_register, length: {is: 18}
  validates :company_register, format: 
            { with: /\A\d{2}\.\d{3}\.\d{3}\/000[1-2]-\d{2}\z/}
  validates :phone_number, length: {is: 12} 
  validates :phone_number, format: { with: /\A\d{7}-\d{4}\z/}
end
