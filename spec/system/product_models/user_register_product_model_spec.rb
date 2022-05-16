require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    #arrange
    supplier1= Supplier.create!(company_name:'Stark Technology Inc', 
                        company_register:'00.178.762/0001-82',
                        brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                        city:'Tatuapé', state:'SP', 
                        email:'contato@tstark.com', phone_number:'6799672-3406')

    supplier2= Supplier.create!(company_name:'Wayne Enterprises Inc', 
                          company_register:'70.190.836/0001-81',
                          brand_name:'WayneCorp',
                          adress:'Avenida Almirante Barroso, 81',
                          city:'Rio de Janeiro', state:'RJ',
                          email:'contato@bwayne.com', 
                          phone_number:'2198405-5854')
    #act
    visit root_path
    within('nav') do
      click_on 'Lista de Produtos'
    end
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: 'Reator Ark'
    fill_in 'Peso', with: 300
    fill_in 'SKU', with: '4RK-R34CT0R'
    fill_in 'Altura', with: 20
    fill_in 'Largura', with: 30
    fill_in 'Profundidade', with: 25
    select 'Stark Industries', from: 'Fornecedor'
    click_on 'Cadastrar'
    #assert
    expect(page).to have_content 'Produto cadastrado com sucesso'
    expect(page).to have_content 'Reator Ark'
    expect(page).to have_content 'SKU: 4RK-R34CT0R'
    expect(page).to have_content 'Fornecedor: Stark Industries'
    expect(page).to have_content 'Dimensões: 20cm x 30cm x 25cm'
    expect(page).to have_content 'Peso: 300g'
  end

  it 'deve preencher todos os campos' do
    #arrange
    supplier= Supplier.create!(company_name:'Stark Technology Inc', 
                        company_register:'00.178.762/0001-82',
                        brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                        city:'Tatuapé', state:'SP', 
                        email:'contato@tstark.com', phone_number:'6799672-3406')
    #act
    visit root_path
    within('nav') do
      click_on 'Lista de Produtos'
    end
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'SKU', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    select 'Stark Industries', from: 'Fornecedor'
    click_on 'Cadastrar'
    #assert
    expect(page).to have_content 'Não foi possível cadastrar o produto'
  end


end