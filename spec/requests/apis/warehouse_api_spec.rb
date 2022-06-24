require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouse/1' do
    it 'sucess' do
      #arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                            adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
                             description:'Galpão destinado para cargas internacionais')
      #act
        get "/api/v1/warehouses/#{warehouse.id}"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response["city"]).to eq('Guarulhos')
    end

  end
end