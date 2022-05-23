def login(usuario)
  click_on 'Entrar'
  fill_in 'E-mail', with: 'jonathan@email.com'
  fill_in 'Senha', with: 'password'
  within('form') do
    click_on 'Entrar'
  end
end