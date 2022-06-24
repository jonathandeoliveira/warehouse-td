require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
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

    product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'R34T0R-4RK', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: :pending)

    order_item = OrderItem.create!(product_model: product, order: order, quantity: 10)

    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'
    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação: Entregue'
    expect(page).not_to have_button 'Marcar como cancelado'
    expect(page).not_to have_button 'Marcar como entregue'
    expect(StockProduct.count).to eq 10
    estoque = StockProduct.where(product_model:product, warehouse:warehouse).count
    expect(estoque).to eq 10
    end

  it 'e pedido foi cancelado' do
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

    product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'R34T0R-4RK', supplier: supplier)

                              
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now, status: :pending)

    order_item = OrderItem.create!(product_model: product, order: order, quantity: 10)

    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Cancelado'
    #assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação: Cancelado'
    expect(StockProduct.count).to eq 0
  end



end