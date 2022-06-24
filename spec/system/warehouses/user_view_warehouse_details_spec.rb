require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do
    #arrange
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                    adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
                    description:'Galpão destinado para cargas internacionais')
    w.save()
    #act
    visit(root_path)
    click_on('Aeroporto SP')

    #assert
    expect(page).to have_content('Código: GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m²')
    expect(page).to have_content('Endereço: Avenida do aeroporto, 1000 CEP:15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
  end

  it 'e volta para a tela inicial' do
    #arrange
    w = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
      description:'Galpão destinado para cargas internacionais')
    #act
    visit '/'
    click_on 'Aeroporto SP'
    click_on 'Voltar'
    #assert
    expect(current_path).to eq('/')
  end
end