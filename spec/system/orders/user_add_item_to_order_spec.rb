require 'rails_helper'
describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do 
    #arrange
    user = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')

    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    product_a = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'R34T0R-4RK', supplier: supplier)

    product_b = ProductModel.create!(name:'MKLXXXV', weight: 85000, width: 40, height:192, 
                        depth:40, sku:'M4RK85', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: 'pending') 
    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'Ark Reactor', from:'Produto'
    fill_in 'Quantidade', with: '5'
    click_on 'Gravar'
    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '5 x Ark Reactor'
  end

  it 'e não vê produtos de outro fornecedor' do
    #arrange
    user = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')

    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier1 = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    supplier2 = Supplier.create!(company_name:'Oscorp Industries', 
                                company_register:'40.468.421/0001-66',
                                brand_name:'Oscorp', adress:'Rua Elvira Harkot Ramina, 177', 
                                city:'Curitiba', state:'PR', 
                                email:'contato@osborn.com', phone_number:'4198165-6478')


    product_a = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'R34T0R-4RK', supplier: supplier1)

    product_b = ProductModel.create!(name:'Pumpkin Bomb', weight: 85000, width: 40, height:192, 
                        depth:40, sku:'P1K1N-B0MB', supplier: supplier2)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier1, deadline_delivery:1.day.from_now, status: 'pending') 
    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'
    #assert
    expect(page).to have_content 'Ark Reactor'
    expect(page).not_to have_content 'Pumpkin Bomb'
  end

end