require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do

    context 'cadastro de novo galpão' do 
      it 'falso quando o nome está vazio' do
      #Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', city: 'Rio', area: 100_000,
          adress: 'endereço', zip_code: '12345-678',
          description:'Galpão')
      #Act
          result = warehouse.valid?
      #Assert
        
          expect(warehouse.valid?).to eq false
      end

      it 'falso quando o código está vazio' do
      #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio', area: 100_000,
          adress: 'endereço', zip_code: '12345-678',
          description:'Galpão')
      #Act
          result = warehouse.valid?
      #Assert
          expect(result).to eq false
      end

      it 'falso quando a cidade  está vazia' do
      #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: '', area: 100_000,
          adress: 'endereço', zip_code: '12345-678',
          description:'Galpão')
      #Act
          result = warehouse.valid?
      #Assert
          expect(result).to eq false
      end

      it 'falso quando área está vazia' do
      #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area:'',
          adress: 'endereço', zip_code: '12345-678',
          description:'Galpão')
      #Act
          result = warehouse.valid?
      #Assert
          expect(result).to eq false
      end

      it 'falso quando o endereço está vazio' do
      #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 100_000,
          adress: '', zip_code: '12345-678',
          description:'Galpão')
      #Act
          result = warehouse.valid?
      #Assert
          expect(result).to eq false
      end
   
      it 'falso quando o cep está vazio' do
      #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 100_000,
          adress: 'endereço', zip_code: '',
          description:'Galpão')
      #Act
          result = warehouse.valid?
      #Assert
          expect(result).to eq false
      end 

      it 'falso quando a descrição está vazia' do
      #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 100_000,
          adress: 'endereço', zip_code: '12345-678',
          description:'')
      #Act
          result = warehouse.valid?
      #Assert
          expect(result).to eq false
      end 
    end

    it 'falso quando um código já está em uso' do
      #arrange
      first_warehouse = Warehouse.create(name: 'Zona Leste', code: 'SPL', city: 'Itaquera', area: 100_000,
                                        adress: 'Rua da Arena Corinthians, 157', zip_code: '12345-678',
                                        description:'Galpão perigoso')

      second_warehouse = Warehouse.new(name: 'Zona Sul', code: 'SPL', city: 'Jabaquara', area: 100_000,
                                  adress: 'rua dois, 2', zip_code: '87654-321',
                                  description:'Galpão feio')
      #act
        result = second_warehouse.valid?
      #assert
      expect(result).to eq false
    end

    it 'falso quando o cep está no formato inválido' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio', area: 100_000,
      adress: 'endereço', zip_code: '12345-68',
      description:'Galpão')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
    

  end

  describe '#full_description' do
    it 'exibe o nome e o código' do
      #arrange
      w = Warehouse.new(name: 'Palmas', code: 'TOC', city: 'Palmas', area: 100_000,
        adress: 'endereço', zip_code: '12345-678',
        description:'Galpão')
      #act
      result = w.full_description()
      #assert
      expect(result).to eq('TOC - Palmas')
    end

  end

end
