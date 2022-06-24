#Users
user1 = User.create!(name:'Jonathan', email:'jonathan@email.com', password:'password')
user2 = User.create!(name:'Larissa', email:'larissa@email.com', password:'password')
user3 = User.create!(name: 'Alexander', email: 'luthor@lexcorp.com', password:'password')
user4 = User.create!(name: 'Tony', email: 'tony@stark.com', password:'password')

#Warehouses
gru = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
                description:'Galpão destinado para cargas internacionais')

spl = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                description:'Galpão perigoso')

sps = Warehouse.create!(name: 'Zona Sul', code: 'SPS', city: 'Jabaquara', area: 100_000,
                  adress: 'rua dois, 2', zip_code: '87654-321',
                  description:'Galpão feio')

abc = Warehouse.create!(name: 'Santo André', code: 'ABC', city: 'Santo André', area: 56_000,
                  adress: 'Rua dos Ferroviários, 150', zip_code: '09010-200',
                  description:'Galpão próximo à linha ferroviária do ABC')


amz =Warehouse.create!(name: 'Manaus', code: 'AMZ', city: 'Manaus', area: 25_000,
                    adress: 'Rua do boto cor de rosa, 150', zip_code: '75060-280',
                    description:'Galpão próximo a zona industrial amazônica')


toc = Warehouse.create!(name: 'Palmas', code: 'TOC', city: 'Palmas', 
                  area: 100_000, adress: 'endereço',
                  zip_code: '12345-678', description:'Galpão')


#Suppliers

stark = Supplier.create!(company_name:'Stark Technology Inc', 
                company_register:'00.178.762/0001-82',
                brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                city:'Tatuapé', state:'SP', 
                email:'contato@tstark.com', phone_number:'6799672-3406')

wayne = Supplier.create!(company_name:'Wayne Enterprises Inc', 
                company_register:'70.190.836/0001-81',
                brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                city:'Rio de Janeiro', state:'RJ',
                email:'contato@bwayne.com', phone_number:'2198405-5854')

oscorp = Supplier.create!(company_name:'Oscorp Industries', 
                company_register:'40.468.421/0001-66',
                brand_name:'Oscorp', adress:'Rua Elvira Harkot Ramina, 177', 
                city:'Curitiba', state:'PR', 
                email:'contato@osborn.com', phone_number:'4198165-6478')


luthor = Supplier.create!(company_name:'LexCorp Incorporated', 
                  company_register:'85.732.736/0001-07',
                  brand_name:'LexCorp', adress:'Av. Portugal, 1148', 
                  city:'Goiânia', state:'GO', 
                  email:'luthor@lexcorp.com', phone_number:'6498673-6917')

#Products

stark_product = ProductModel.create!(name:'Ark Reactor', weight: 1000, width: 15, height:4, 
                                    depth:6, sku:'R34T0R-4RK', supplier: stark)

stark_product2 = ProductModel.create!(name:'JARVIS', weight: 1, width: 1, height:1, 
                                      depth:1, sku:'J4RV1S', supplier: stark)

stark_product3 = ProductModel.create!(name:'MKLXXXV', weight: 85000, width: 40, height:192, 
                                      depth:40, sku:'M4RK85', supplier: stark)

oscorp_product = ProductModel.create!(name:'Pumpkin Bomb', weight: 85000, width: 40, height:192, 
                                      depth:40, sku:'P1K1N-B0MB', supplier: oscorp)

wayne_product = ProductModel.create!(name:'Batrang', weight: 1000, width: 15, height:4, 
                                        depth:6, sku:'B4TR4NGU3', supplier: wayne)

wayne_product2 =  ProductModel.create!(name:'Grapplin Gun', weight: 5000, width: 30, height:30, 
                                        depth:20, sku:'B4TC0RD4', supplier: wayne)


#Orders

order = Order.create!(user: user1, warehouse: abc, supplier: stark, deadline_delivery:1.day.from_now, status: :pending)
order_item = OrderItem.create!(product_model: stark_product, order: order, quantity: 10)



