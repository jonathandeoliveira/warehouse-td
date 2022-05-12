require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do

  it ' a partir da tela inicial' do
    #arrange
    Supplier.create!(company_name:'Oscorp Industries', 
      company_register:'40.468.421/0001-66',
      brand_name:'Oscorp', adress:'Rua Elvira Harkot Ramina, 177', 
      city:'Curitiba', state:'PR', 
      email:'contato@osborn.com', phone_number:'4198165-6478')
    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Oscorp'
    #assert
    expect(page).to have_content('Detalhes sobre o fornecedor:')
    expect(page).to have_content('Oscorp Industries')
    expect(page).to have_content('CPNJ: 40.468.421/0001-66 ')
    expect(page).to have_content('Endereço: Rua Elvira Harkot Ramina, 177 - Curitiba - PR')
    expect(page).to have_content('Telefone: 4198165-6478')
    expect(page).to have_content('E-mail: contato@osborn.com')
  end

  it 'e volta para a tela de fornecedores ' do
     #arrange
     Supplier.create!(company_name:'Oscorp Industries', 
      company_register:'40.468.421/0001-66',
      brand_name:'Oscorp', adress:'Rua Elvira Harkot Ramina, 177', 
      city:'Curitiba', state:'PR', 
      email:'contato@osborn.com', phone_number:'4198165-6478')
    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Oscorp'
    click_on 'Voltar'
    #assert
    expect(current_path).to eq suppliers_path
  end

  it 'e volta para a tela inicial ' do
    #arrange
    Supplier.create!(company_name:'Oscorp Industries', 
     company_register:'40.468.421/0001-66',
     brand_name:'Oscorp', adress:'Rua Elvira Harkot Ramina, 177', 
     city:'Curitiba', state:'PR', 
     email:'contato@osborn.com', phone_number:'4198165-6478')
   #act
   visit root_path
   click_on 'Fornecedores'
   click_on 'Oscorp'
   click_on 'Home'
   #assert
   expect(current_path).to eq root_path
 end

end