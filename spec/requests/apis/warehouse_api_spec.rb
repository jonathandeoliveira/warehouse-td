require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouses/1' do
    it 'com sucesso' do
      # arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    adress: 'Avenida do aeroporto, 1000', zip_code: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      # act
      get "/api/v1/warehouses/#{warehouse.id}"
      # assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('GRU')
      expect(json_response['city']).to eq('Guarulhos')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'falha se não encontra um galpão' do
      # arrange
      # act
      get '/api/v1/warehouses/9999'
      # assert
      expect(response.status).to eq 404
    end
  end

  context 'GET/api/v1/warehouses' do
    it 'com sucesso, ordenado por nome' do
      # arrange
      warehouse1 = Warehouse.create!(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                                     adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                                     description: 'Galpão perigoso')
      warehouse2 = Warehouse.create!(name: 'Santo André', code: 'AAC', city: 'Santo André', area: 56_000,
                                     adress: 'Rua dos Ferroviários, 150', zip_code: '09010-200',
                                     description: 'Galpão próximo à linha ferroviária do ABC')
      # act
      get '/api/v1/warehouses'
      # assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Santo André'
      expect(json_response[1]['name']).to eq 'Zona Leste'
    end

    it 'retorna vazio, caso não existam galpões' do
      # arrange
      # act
      get '/api/v1/warehouses'
      # assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e apresenta erro interno' do
      # arrange
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
      # act
      get '/api/v1/warehouses'
      # assert
      expect(response).to have_http_status 500
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'com sucesso' do
      # arrange
      warehouse_params = { warehouse: { name: 'Galpão da API', code: 'API', city: 'Salvador', area: 100_000,
                                        adress: 'Rua da API, 225', zip_code: '12345-678',
                                        description: 'Galpão de teste da api' } }
      # act
      post '/api/v1/warehouses', params: warehouse_params
      # assert
      expect(response).to have_http_status(:created)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Galpão da API')
      expect(json_response['code']).to eq('API')
      expect(json_response['city']).to eq('Salvador')
      expect(json_response['area']).to eq(100_000)
      expect(json_response['adress']).to eq('Rua da API, 225')
      expect(json_response['zip_code']).to eq('12345-678')
      expect(json_response['description']).to eq('Galpão de teste da api')
    end

    it 'sem sucesso, parametros incompletos' do
      # arrange
      warehouse_params = { warehouse: { name: 'Galpão de erro da API', city: 'Salvador', area: 100_000,
                                        adress: 'Rua da API, 225', zip_code: '12345-678',
                                        description: 'Galpão de teste da api' } }
      # act
      post '/api/v1/warehouses', params: warehouse_params
      # assert
      expect(response).to have_http_status(412)
      expect(response.body).to include 'Código não pode ficar em branco'
      expect(response.body).to include 'Código não possui o tamanho esperado (3 caracteres)'
      expect(response.body).not_to include 'Nome não pode ficar em branco'
    end

    it 'falha caso haja erro interno' do
      # arrange
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: { name: 'Galpão da API', code: 'API', city: 'Salvador', area: 100_000,
                                        adress: 'Rua da API, 225', zip_code: '12345-678',
                                        description: 'Galpão de teste da api' } }
      # act
      post '/api/v1/warehouses', params: warehouse_params
      # assert
      expect(response).to have_http_status(500)
    end
  end
end
