require 'rails_helper'

describe 'Usuario visita a tela inicial' do
  it 'e vê o nome da app' do
    #arrange

    #act
    visit('/')

    #assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    #arrange
    # cadastrar 2 galpoes: Rio e Maceio
    Warehouse.create(name:'Rio', code:'SDU', city:'Rio de Janeiro', area:60_000)
    Warehouse.create(name:'Maceio', code:'MCZ', city:'Maceio', area:50_000)

    #act
    visit('/')

    #assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    # garantir que eu vejo na tela os galpoes Rio e Maceio
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('50000 m²')
    end

  it 'e não existem galpões cadastrados' do
    #arrange

    #act
    visit('/')

    #assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end
