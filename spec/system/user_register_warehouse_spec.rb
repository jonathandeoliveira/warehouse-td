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
    fill_in 'CEP:', with: '20200-00'
    fill_in'Área:', with: '32000'
    click_on 'Cadastrar'

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RIO'
    expect(page).to have_content '32000 m²'
  end
  
end