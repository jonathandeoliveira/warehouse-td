require 'rails_helper'

describe 'Usuário remove um galpão' do

  it 'com sucesso' do
    #arrange
    w = Warehouse.create!(name: 'Manaus', code: 'AMZ', city: 'Manaus', area: 25_000,
      adress: 'Rua do boto cor de rosa, 150', zip_code: '75060-280',
      description:'Galpão próximo a zona industrial amazônica')
    #act
    visit root_path
    click_on 'Manaus'
    click_on 'Remover'
    #assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Galpão removido com sucesso'
      expect(page).not_to have_content 'Manaus'
      expect(page).not_to have_content 'AMZ'
  end

  it 'e não apaga outros galpões' do
    #arrange
    first_warehouse = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                                        adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                                        description:'Galpão perigoso')
    second_warehouse = Warehouse.create!(name: 'Zona Sul', code: 'SPS', city: 'Jabaquara', area: 100_000,
                                        adress: 'rua dois, 2', zip_code: '87654-321',
                                        description:'Galpão feio')
    #act
    visit root_path
    click_on 'Zona Leste'
    click_on 'Remover'
      #assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Galpão removido com sucesso'
      expect(page).to have_content  'Zona Sul'
      expect(page).not_to have_content 'Zona leste'
      expect(page).not_to have_content 'SPL'
  end

end