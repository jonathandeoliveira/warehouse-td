require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it ' a partir da tela inicial' do
    #arrange
    Supplier.create!(company_name:'Wayne Enterprises Inc', 
                  company_register:'70.190.836/0001-81',
                  brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                  city:'Rio de Janeiro', state:'RJ',
                  email:'contato@bwayne.com', phone_number:'2198405-5854')
    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'WayneCorp'
    click_on 'Editar'
    #assert
    expect(page).to have_field('Razão Social', with:'Wayne Enterprises Inc')
    expect(page).to have_field('CPNJ', with: '70.190.836/0001-81')
    expect(page).to have_field('Nome Fantasia', with:'WayneCorp')
    expect(page).to have_field('Endereço', with:'Avenida Almirante Barroso, 81')
    expect(page).to have_field('Cidade', with:'Rio de Janeiro')
    expect(page).to have_field('Estado', with:'RJ')
    expect(page).to have_field('E-mail', with:'contato@bwayne.com')
    expect(page).to have_field('Telefone', with:'2198405-5854')
  end

  it 'com sucesso' do
    #arrange
    Supplier.create!(company_name:'Wayne Enterprises Inc', 
                    company_register:'70.190.836/0001-81',
                    brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                    city:'Rio de Janeiro', state:'RJ',
                    email:'contato@bwayne.com', phone_number:'2198405-5854')
    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'WayneCorp'
    click_on 'Editar'
    fill_in 'Cidade', with:'Petrópolis'
    fill_in 'Telefone', with:'2198408-5859'
    fill_in 'E-mail', with:'bruce@wayne.com'
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Avenida Almirante Barroso, 81 - Petrópolis - RJ'
    expect(page).to have_content '2198408-5859'
    expect(page).to have_content 'bruce@wayne.com'
  end

  it 'e mantém os campos obrigatórios' do
    #arrange
    Supplier.create!(company_name:'Wayne Enterprises Inc', 
                  company_register:'70.190.836/0001-81',
                  brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                  city:'Rio de Janeiro', state:'RJ',
                  email:'contato@bwayne.com', phone_number:'2198405-5854')
    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'WayneCorp'
    click_on 'Editar'
    fill_in 'Cidade' , with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail' , with: ''
    click_on 'Cadastrar'

    #assert
    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
  end

end