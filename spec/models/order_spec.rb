require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'código é obrigatório' do
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
        order = Order.new(user: user, warehouse: warehouse, 
                          supplier: supplier, deadline_delivery:'2022-06-08')
        #act
        result = order.valid?
        #assert
        expect(result).to be true
    end




  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
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
      order = Order.new(user: user, warehouse: warehouse, 
                        supplier: supplier, deadline_delivery:'2022-06-08')
      #act
      order.save!
      result = order.code
      #assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8

    end

    it 'e o código é unico' do
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
      order1 = Order.create!(user: user, warehouse: warehouse, 
                        supplier: supplier, deadline_delivery:'2022-06-08')
      order2 = Order.new(user: user, warehouse: warehouse, 
                          supplier: supplier, deadline_delivery:'2022-09-20')
      #act
      order2.save!
      #assert
      expect(order2.code).not_to eq order1.code

    end


  end

end