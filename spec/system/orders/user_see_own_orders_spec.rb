require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do 
  it 'e deve estar autenticado' do
    #arrange

    #act
    visit root_path
    click_on 'Meus Pedidos'
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê pedidos alheios' do
    #arrange
    user1 = User.create!(name:'Raul' , email:'raul@email.com' , password:'password')
    user2 = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')
    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    order1 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    order2 = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    order3 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)
    #act
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'
    #assert
    expect(page).to have_content order1.code
    expect(page).not_to have_content order2.code
    expect(page).to have_content order3.code
  end
end