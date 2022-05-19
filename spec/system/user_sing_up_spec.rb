require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #arrange
    #act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Pedro'
    fill_in 'E-mail', with: 'pedro@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    #assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Olá Pedro.'
    expect(page).to have_content 'pedro@email.com'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Pedro'
  end
end