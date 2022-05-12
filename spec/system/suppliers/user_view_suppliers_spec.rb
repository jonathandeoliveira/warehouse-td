require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    #arrange
    #act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    #assert
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    #arrange
    Supplier.create!(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663', 
                    city:'Tatuapé', state:'SP', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')

    Supplier.create!(company_name:'Wayne Enterprises Inc', 
                    company_register:'70.190.836/0001-81',
                    brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81', 
                    city:'Rio de Janeiro', state:'RJ',
                    email:'contato@bwayne.com', phone_number:'4398405-5854')
    #act
    visit root_path
    click_on 'Fornecedores'
    #assert
    expect(page).to have_content('Lista de fornecedores')
    expect(page).to have_content('Stark Industries')
    expect(page).to have_content('Tatuapé - SP')
    expect(page).to have_content('WayneCorp')
    expect(page).to have_content('Rio de Janeiro - RJ')
  end

  it 'e não existem fornecedores cadastratos' do
    #arrange

    #act
    visit(root_path)
    within('nav') do
      click_on 'Fornecedores'
    end
    #assert
    expect(page).to have_content('Não existem fornecedores cadastrados')
  end


end