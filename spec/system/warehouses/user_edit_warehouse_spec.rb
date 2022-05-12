require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    #arrange
    w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
      description:'Galpão destinado para cargas internacionais')
    #act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    #assert
    expect(page).to have_field('Nome:', with:'Aeroporto SP')
    expect(page).to have_field('Descrição:', with: 'Galpão destinado para cargas internacionais')
    expect(page).to have_field('Código:', with:'GRU')
    expect(page).to have_field('Endereço:', with:'Avenida do aeroporto, 1000')
    expect(page).to have_field('Cidade:', with:'Guarulhos')
    expect(page).to have_field('CEP:', with:'15000-000')
    expect(page).to have_field('Área:', with:'100000')
  end

  it 'com sucesso' do
    #arrange
    w = Warehouse.create!(name: 'Santo André', code: 'AAC', city: 'Santo André', area: 56_000,
                          adress: 'Rua dos Ferroviários, 150', zip_code: '09010-200',
                          description:'Galpão próximo à linha ferroviária do ABC')
    #act
    visit root_path
    click_on 'Santo André'
    click_on 'Editar'
    fill_in 'Código:' , with: 'ABC'
    fill_in 'CEP:', with: '09030-210'
    fill_in 'Área:' , with: '80000'
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Código:ABC'
    expect(page).to have_content 'Área:80000 m²'
    expect(page).to have_content 'CEP:09030-210'
  end

  it 'e mantém os campos obrigatórios' do
    #arrange
    w = Warehouse.create!(name: 'Santo André', code: 'AAC', city: 'Santo André', area: 56_000,
                          adress: 'Rua dos Ferroviários, 150', zip_code: '09010-200',
                          description:'Galpão próximo à linha ferroviária do ABC')
    #act
    visit root_path
    click_on 'Santo André'
    click_on 'Editar'
    fill_in 'Código:' , with: ''
    fill_in 'CEP:', with: ''
    fill_in 'Área:' , with: ''
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content 'Não foi possível atualizar o galpão'
    

  end

end
