require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela de um galpão' do
    #arrange
    user = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')

    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    product_a = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'R34T0R-4RK', supplier: supplier)

    product_b = ProductModel.create!(name:'Armor MKLXXXV', weight: 85000, width: 40, height:192, 
                        depth:40, sku:'4RM0R-M4RK85', supplier: supplier)

    product_c = ProductModel.create!(name:'JARVIS', weight: 1, width: 1, height:1, 
                          depth:1, sku:'J4RV1S', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.month.from_now, status: 'pending')

    7.times{ StockProduct.create!(order:order,warehouse:warehouse,product_model:product_a) }
    3.times{ StockProduct.create!(order:order,warehouse:warehouse,product_model:product_b) }
    #act
    login_as(user)
    visit root_path
    click_on 'Zona Leste'
    #assert
    expect(page).to have_content 'Itens em estoque'
    expect(page).to have_content '7 x Ark Reactor'
    expect(page).to have_content '3 x Armor MKLXXXV'
    expect(page).not_to have_content 'JARVIS'
  end

  it 'e dá baixa em um item' do
    #arrage
    user = User.create!(name: 'Paulo' , email:'paulo@email.com' , password:'password')

    warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                      adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                      description:'Galpão perigoso')

    supplier = Supplier.create!(company_name:'Stark Technology Inc', 
                              company_register:'00.178.762/0001-82',
                              brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                              city:'Tatuapé', state:'SP', 
                              email:'contato@tstark.com', phone_number:'6799672-3406')

    product_a = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                        depth:6, sku:'R34T0R-4RK', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, deadline_delivery:1.month.from_now, status: 'pending')

    7.times{ StockProduct.create!(order:order,warehouse:warehouse,product_model:product_a) }

    #act
    login_as(user)
    visit root_path
    click_on 'Zona Leste'
    select 'R34T0R-4RK', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - SP'
    click_on 'Confirmar Retirada'
    #assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '6 x R34T0R-4RK'
  end


end