require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do 
  it 'e deve estar autenticado' do
    #arrange

    #act
    visit root_path
    click_on 'Meus Pedidos'
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê pedidos alheios' do
    #arrange
    user1 = User.create!(name:'Raul' , email:'raul@email.com' , password:'password')
    user2 = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')
    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    order1 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: 'pending')
    order2 = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: 'delivered')
    order3 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: 'canceled')
    #act
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'
    #assert
    expect(page).to have_content order1.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content order2.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content order3.code
    expect(page).to have_content 'Cancelado'
  end


  it 'e visita um pedido' do
    #arrange
    user = User.create!(name:'Raul' , email:'raul@email.com' , password:'password')
    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code 
    #assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão destino: SPL - Zona Leste'
    expect(page).to have_content 'Fornecedor: Stark Industries'
    formated_date = I18n.l(1.day.from_now.to_date)
    expect(page).to have_content "Data prevista para entrega: #{formated_date}"
  end

  
  it 'e não vê pedidos alheios' do
    #arrange
    user1 = User.create!(name:'Raul' , email:'raul@email.com' , password:'password')
    user2 = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')
    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')
    order = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    login_as(user1)
    visit order_path(order.id)
    #assert
    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Erro! Página não encontrada'

  end

  it 'e vê itens do pedido' do
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

    product_c = ProductModel.create!(name:'JARVIS', weight: 1, width: 1, height:1, 
                          depth:1, sku:'J4RV1S', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: 'pending')

    OrderItem.create!(product_model: product_a, order: order, quantity: 9)
    OrderItem.create!(product_model: product_b, order: order, quantity: 2)
    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    #assert
    expect(page).to have_content 'Itens do pedido'
    expect(page).to have_content '9 x Ark Reactor'
    expect(page).to have_content '2 x MKLXXXV'
  end



end