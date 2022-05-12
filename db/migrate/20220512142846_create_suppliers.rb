class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :company_name
      t.string :company_register
      t.string :brand_name
      t.string :adress
      t.string :city
      t.string :state
      t.string :email

      t.timestamps
    end
  end
end
