require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'devendo estar autenticado' do
    #arrange
    #act
    visit root_path
    click_on 'Registrar pedido'
    #assert
    expect(current_path).to eq new_user_session_path
  end



  it 'com sucesso' do
    #arrange
    user = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')
    Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
      description:'Galpão destinado para cargas internacionais')
    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')
    Supplier.create!(company_name:'Wayne Enterprises Inc', 
                    company_register:'70.190.836/0001-81',
                    brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                    city:'Rio de Janeiro', state:'RJ',
                    email:'contato@bwayne.com', phone_number:'2198405-5854')
    supplier = Supplier.create!(company_name:'Oscorp Industries', 
                                company_register:'40.468.421/0001-66',
                                brand_name:'Oscorp', adress:'Rua Elvira Harkot Ramina, 177',
                                city:'Curitiba', state:'PR', 
                                email:'contato@osborn.com', phone_number:'4198165-6478')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('8DIGITOS')
    #act
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select  'SPL - Zona Leste', from: 'Galpão destino'
    select  supplier.company_name, from: 'Fornecedor'
    fill_in 'Data prevista para entrega', with: '08/06/2022'
    click_on 'Criar pedido'
    #assert
      expect(page).to have_content 'Pedido registrado com sucesso'
      expect(page).to have_content 'Pedido 8DIGITOS'
      expect(page).to have_content 'Galpão destino: SPL - Zona Leste'
      expect(page).to have_content 'Fornecedor: Oscorp Industries'
      expect(page).to have_content 'Usuário responsável: Jonathan - jonathan@email.com'
      expect(page).to have_content 'Data prevista para entrega: 08/06/2022'
      expect(page).not_to have_content 'Aeroporto SP'
      expect(page).not_to have_content 'Wayne Enterprises Inc'
  end
end