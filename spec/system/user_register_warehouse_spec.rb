require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    #arrenge
    

    #act
    visit(root_path)
    click_on 'Cadastrar novo galpão'

    #assert
    expect(page).to have_field('Nome:')
    expect(page).to have_field('Descrição:')
    expect(page).to have_field('Código:')
    expect(page).to have_field('Endereço:')
    expect(page).to have_field('Cidade:')
    expect(page).to have_field('CEP:')
    expect(page).to have_field('Área:')
  end

  it 'com sucesso' do
    #arrange

    #Act
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome:', with: 'Rio de Janeiro'
    fill_in 'Descrição:', with: 'Galpão da zona portuária do Rio'
    fill_in 'Código:', with: 'RIO'
    fill_in 'Endereço:', with: 'Avenida Porto Rio de janeiro, 2000'
    fill_in 'Cidade:', with:  'Rio de Janeiro'
    fill_in 'CEP:', with: '20200-000'
    fill_in'Área:', with: '32000'
    click_on 'Cadastrar'

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso!'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RIO'
    expect(page).to have_content '32000 m²'
  end
  
  it 'com dados incompletos' do
    #arrange

    #act
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome:', with: ''
    fill_in 'Descrição:', with: ''
    fill_in'Área:', with: ''
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Descrição não pode ficar em branco"
    expect(page).to have_content "Área não pode ficar em branco"
  end

  it 'Com nome e código repetidos' do
    #arrange
    warehouse = Warehouse.create(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                                adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                                description:'Galpão perigoso')
    #Act
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome:', with: 'Zona Leste'
    fill_in 'Descrição:', with: 'Galpão perigoso'
    fill_in 'Código:', with: 'SPL'
    fill_in 'Endereço:', with: 'Rua da Arena Corinthians, 157'
    fill_in 'Cidade:', with:  'Itaquera'
    fill_in 'CEP:', with: '12345-678'
    fill_in'Área:', with: '100000'
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content "Nome já está em uso"
    expect(page).to have_content "Código já está em uso"
  end

  it 'Com código fora do formato' do
    #Arrange
    #Act
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome:', with: 'Zona Leste'
    fill_in 'Descrição:', with: 'Galpão perigoso'
    fill_in 'Código:', with: 'SPL'
    fill_in 'Endereço:', with: 'Rua da Arena Corinthians, 157'
    fill_in 'Cidade:', with:  'Itaquera'
    fill_in 'CEP:', with: '12345-5555'
    fill_in'Área:', with: '100000'
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content 'CEP não é válido'

  end



end