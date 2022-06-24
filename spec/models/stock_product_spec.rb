require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do

    it 'ao criar um StockProduct' do
      #arrange
      user = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')

      warehouse = Warehouse.create!(name: 'Palmas', code: 'TOC', city: 'Palmas', 
                                    area: 100_000, adress: 'endereço',
                                    zip_code: '12345-678', description:'Galpão')

      supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                                  company_register:'00.178.762/0001-82',
                                  brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                                  city:'Tatuapé', state:'SP', 
                                  email:'contato@tstark.com', phone_number:'6799672-3406')

      product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                                    depth:6, sku:'R34T0R-4RK', supplier: supplier)

      order = Order.create!(user: user, warehouse: warehouse, 
                            supplier: supplier, deadline_delivery:1.week.from_now, status: :delivered)

      #act
      stock_product = StockProduct.create!(order: order, warehouse:warehouse,product_model:product)
      #assert
      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      #arrange
      user = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')
  
      warehouse = Warehouse.create!(name: 'Palmas', code: 'TOC', city: 'Palmas', 
                                    area: 100_000, adress: 'endereço',
                                    zip_code: '12345-678', description:'Galpão')

      warehouse2 = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                          adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
                          description:'Galpão destinado para cargas internacionais')
  
      supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                                  company_register:'00.178.762/0001-82',
                                  brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                                  city:'Tatuapé', state:'SP', 
                                  email:'contato@tstark.com', phone_number:'6799672-3406')
  
      product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                                    depth:6, sku:'R34T0R-4RK', supplier: supplier)
  
      order = Order.create!(user: user, warehouse: warehouse, 
                            supplier: supplier, deadline_delivery:1.week.from_now, status: :delivered)
      stock_product = StockProduct.create!(order: order, warehouse:warehouse,product_model:product)
      original_serial = stock_product.serial_number
      #act
      stock_product.update(warehouse:warehouse2)
      #assert
      expect(stock_product.serial_number).to eq original_serial
    end
  end


  describe '#availabe?' do
    it 'true se não possuir destino' do
      #arrange
      user = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')

      warehouse = Warehouse.create!(name: 'Palmas', code: 'TOC', city: 'Palmas', 
                                    area: 100_000, adress: 'endereço',
                                    zip_code: '12345-678', description:'Galpão')

      supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                                  company_register:'00.178.762/0001-82',
                                  brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                                  city:'Tatuapé', state:'SP', 
                                  email:'contato@tstark.com', phone_number:'6799672-3406')

      product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                                    depth:6, sku:'R34T0R-4RK', supplier: supplier)

      order = Order.create!(user: user, warehouse: warehouse, 
                            supplier: supplier, deadline_delivery:1.week.from_now, status: :delivered)

      #act
      stock_product = StockProduct.create!(order: order, warehouse:warehouse,product_model:product)
      #assert
      expect(stock_product.availabe?).to eq true
    end

    it 'true se não possuir destino' do
      #arrange
      user = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')

      warehouse = Warehouse.create!(name: 'Palmas', code: 'TOC', city: 'Palmas', 
                                    area: 100_000, adress: 'endereço',
                                    zip_code: '12345-678', description:'Galpão')

      supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                                  company_register:'00.178.762/0001-82',
                                  brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                                  city:'Tatuapé', state:'SP', 
                                  email:'contato@tstark.com', phone_number:'6799672-3406')

      product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                                    depth:6, sku:'R34T0R-4RK', supplier: supplier)

      order = Order.create!(user: user, warehouse: warehouse, 
                            supplier: supplier, deadline_delivery:1.week.from_now, status: :delivered)

      #act
      stock_product = StockProduct.create!(order: order, warehouse:warehouse,product_model:product)
      stock_product.create_stock_product_destination!(recipient:'Jonathan', adress:'Rua Oliveira')
      #assert
      expect(stock_product.availabe?).to eq false
    end

  end









  
end
