require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do

  it 'a partir da tela inicial' do
    #arrange

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    #assert
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CPNJ')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Telefone')
  end

  it 'com sucesso' do
    #arrange

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: 'LexCorp Incorporated'
    fill_in 'CPNJ', with: '85.732.736/0001-07'
    fill_in 'Nome Fantasia', with: 'LexCorp'
    fill_in 'Endereço', with: 'Av. Portugal, 1148'
    fill_in 'Cidade', with: 'Goiânia'
    fill_in 'Estado', with: 'GO'
    fill_in 'E-mail', with: 'luthor@lexcorp.com'
    fill_in 'Telefone', with: '6498673-6917'
    click_on 'Cadastrar'
    #assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
    expect(page).to have_content 'LexCorp'
    expect(page).to have_content 'Goiânia - GO'
  end

  it 'Com dados incompletos' do
    #arrange

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'CPNJ', with: ''
    fill_in 'Nome Fantasia', with: ''
    click_on 'Cadastrar'
    #assert
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "CPNJ não pode ficar em branco"
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
  end

  it 'com CPNJ e telefone fora do formato' do
    #arrange

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: 'LexCorp Incorporated'
    fill_in 'CPNJ', with: '85-732-736/0001.07'
    fill_in 'Nome Fantasia', with: 'LexCorp'
    fill_in 'Endereço', with: 'Av. Portugal, 1148'
    fill_in 'Cidade', with: 'Goiânia'
    fill_in 'Estado', with: 'GO'
    fill_in 'E-mail', with: 'luthor@lexcorp.com'
    fill_in 'Telefone', with: '64-986736917'
    click_on 'Cadastrar'
    #assert
    expect(page).to have_content 'CPNJ não é válido'
    expect(page).to have_content 'Telefone não é válido'
  end

end