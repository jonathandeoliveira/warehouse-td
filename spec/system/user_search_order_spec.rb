require 'rails_helper'

describe 'Usuário busca por um pedido' do 
  it 'a partir do menu' do
    #arrange
    user = User.create!(name:'email', email: 'email@email.com', password:'password')
    #act
    login_as(user)
    visit root_path
    #assert
    within('header nav') do
    expect(page).to have_field('Rastrear pedido')
    expect(page).to have_button('Buscar')
    end
  end

  it 'e deve estar autenticado' do
    #arrange
    #act
    visit root_path
    #assert
    within('header nav') do
      expect(page).not_to have_field('Rastrear pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
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

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    login_as(user)
    visit root_path
    fill_in 'Rastrear pedido', with: order.code
    click_on 'Buscar'
    #assert
    within('main') do
    expect(page).to have_content "Resultados da busca por: #{order.code}"
    expect(page).to have_content "Galpão destino: TOC - Palmas"
    expect(page).to have_content "Fornecedor: Stark Industries"
    expect(page).to have_content "Usuário responsável: Jonathan"
    expect(page).to have_content "Data prevista para entrega: #{order.deadline_delivery}"
    end
  end



  it 'e encontra múltiplos pedidos' do
    #arrange
    user = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')

    warehouse1 = Warehouse.create!(name: 'Palmas', code: 'TOC', city: 'Palmas', 
                          area: 100_000, adress: 'endereço',
                          zip_code: '12345-678', description:'Galpão')
    warehouse2 = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                               company_register:'00.178.762/0001-82',
                               brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('TOC12345')
    order1 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, deadline_delivery:1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('TOC54321')
    order2 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, deadline_delivery:1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('8DIGITOS')
    order3 = Order.create!(user: user, warehouse: warehouse2, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    login_as(user)
    visit root_path
    fill_in 'Rastrear pedido', with: 'TOC'
    click_on 'Buscar'
    #assert
    within('main') do
      expect(page).to have_content '2 Pedidos encontrados'
      expect(page).to have_content 'TOC12345'
      expect(page).to have_content 'TOC54321'
      expect(page).to have_content 'Galpão destino: TOC - Palmas'
      expect(page).not_to have_content '8DIGITOS'
      expect(page).not_to have_content 'Galpão destino: SPL - Zona Leste'
    end
  end


end