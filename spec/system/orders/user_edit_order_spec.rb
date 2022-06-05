require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticado' do
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
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    visit edit_order_path(order.id)
    #assert
    expect(current_path).to eq new_user_session_path
  end


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
    supplier2 = Supplier.create!(company_name:'Wayne Enterprises Inc', 
                    company_register:'70.190.836/0001-81',
                    brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                    city:'Rio de Janeiro', state:'RJ',
                    email:'contato@bwayne.com', phone_number:'2198405-5854')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data prevista para entrega', with: '15/08/2022'
    select 'WayneCorp', from: 'Fornecedor'
    click_on 'Gravar'
    #assert
    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: WayneCorp'
    expect(page).to have_content 'Data prevista para entrega: 15/08/2022'
  end

  it 'caso seja responsável' do
    #arrange
    user = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')
    user2 = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')

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
    login_as(user2)
    visit edit_order_path(order.id)
    #assert
    expect(current_path).to eq root_path
  end





end