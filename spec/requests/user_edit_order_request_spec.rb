require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é dono do pedido' do
    #arrange
    user = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')
    user2 = User.create!(name:'Jonathan', email:'jonathan@email.com' ,password:'password')
    
    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.day.from_now)

    #act
    login_as(user2)
    patch(order_path(order.id), params:{order: { supplier_id: 3 }})
    #assert
    expect(response).to redirect_to(root_path)
  end
end