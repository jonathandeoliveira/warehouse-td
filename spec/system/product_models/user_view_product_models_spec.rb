require 'rails_helper'

describe 'Vê a lista de produtos' do

  it 'se estiver autenticado' do
    #arrange
    #act
    visit root_path
    within('nav') do
      click_on 'Lista de Produtos'
    end
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'através do menu' do
    #arrange
    user = User.create!(name: 'Jonathan', email:'jonathan@email.com', password: 'password')
    #act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Lista de Produtos'
    end
    #assert
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    #arrange
    user = User.create!(name: 'Jonathan', email:'jonathan@email.com', password: 'password')
    fornecedor = Supplier.create!(company_name:'Wayne Enterprises Inc', 
                                  company_register:'70.190.836/0001-81',
                                  brand_name:'WayneCorp',
                                  adress:'Avenida Almirante Barroso, 81', 
                                  city:'Rio de Janeiro', state:'RJ',
                                  email:'contato@bwayne.com', 
                                  phone_number:'4398405-5854')
    ProductModel.create!(name:'Batrang', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'B4TR4NGU3', supplier: fornecedor)
    ProductModel.create!(name:'Grapplin Gun', weight: 5000, width: 30, height:30, 
                        depth:20, sku:'B4TC0RD4', supplier: fornecedor)
    #act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Lista de Produtos'
    end
    #assert
    expect(page).to have_content 'Batrang'
    expect(page).to have_content 'B4TR4NGU3'
    expect(page).to have_content 'WayneCorp'
    expect(page).to have_content 'Grapplin Gun'
    expect(page).to have_content 'B4TC0RD4'
  end

  it 'e não existem produtos cadastrados' do
    #arrange
    user = User.create!(name: 'Jonathan', email:'jonathan@email.com', password: 'password')
    #act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Lista de Produtos'
    end
    #assert
    expect(page).to have_content('Não existem produtos cadastrados')
  end

end