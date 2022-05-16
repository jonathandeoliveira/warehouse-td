require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'cadastro de novo produto' do
      it 'nome é obrigatório' do
        # arrange
        supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                    company_register: '70.190.836/0001-81',
                                    brand_name: 'WayneCorp',
                                    adress: 'Avenida Almirante Barroso, 81',
                                    city: 'Rio de Janeiro', state: 'RJ',
                                    email: 'contato@bwayne.com',
                                    phone_number: '2198405-5854')

        product = ProductModel.new(name: '', weight: 1000, width: 15,
                                   height: 4, depth: 6, sku: 'B4TR4NGU3', supplier: supplier)
        # act
        result = product.valid?
        # assert
        expect(result).to eq false
      end

      it 'SKU é obrigatório' do
        # arrange
        supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                    company_register: '70.190.836/0001-81',
                                    brand_name: 'WayneCorp',
                                    adress: 'Avenida Almirante Barroso, 81',
                                    city: 'Rio de Janeiro', state: 'RJ',
                                    email: 'contato@bwayne.com',
                                    phone_number: '2198405-5854')

        product = ProductModel.new(name: 'Batrang', weight: 1000, width: 15,
                                   height: 4, depth: 6, sku: '', supplier: supplier)
        # act
        result = product.valid?
        # assert
        expect(result).to eq false
      end

      it 'Peso é obrigatório' do
        # arrange
        supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                    company_register: '70.190.836/0001-81',
                                    brand_name: 'WayneCorp',
                                    adress: 'Avenida Almirante Barroso, 81',
                                    city: 'Rio de Janeiro', state: 'RJ',
                                    email: 'contato@bwayne.com',
                                    phone_number: '2198405-5854')

        product = ProductModel.new(name: 'Batrang', weight: '', width: 15,
                                   height: 4, depth: 6, sku: 'B4TR4NGU3', supplier: supplier)
        # act
        result = product.valid?
        # assert
        expect(result).to eq false
      end

      it 'SKU é deve ser único' do
        # arrange
        supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                    company_register: '70.190.836/0001-81',
                                    brand_name: 'WayneCorp',
                                    adress: 'Avenida Almirante Barroso, 81',
                                    city: 'Rio de Janeiro', state: 'RJ',
                                    email: 'contato@bwayne.com',
                                    phone_number: '2198405-5854')
        product1 =ProductModel.create!(name:'Grapplin Gun', weight: 5000, width: 30, height:30, 
                                      depth:20, sku:'B4TC0RD4', supplier: supplier)
        product2 = ProductModel.new(name: 'Batrang', weight: '', width: 15,
                                   height: 4, depth: 6, sku: 'B4TC0RD4', supplier: supplier)
        # act
        result = product2.valid?
        # assert
        expect(result).to eq false
      end


      context 'Dimensões' do
        it 'Peso não pode ser menor que 1' do
          # arrange
          supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                      company_register: '70.190.836/0001-81',
                                      brand_name: 'WayneCorp',
                                      adress: 'Avenida Almirante Barroso, 81',
                                      city: 'Rio de Janeiro', state: 'RJ',
                                      email: 'contato@bwayne.com',
                                      phone_number: '2198405-5854')

          product = ProductModel.new(name: 'Batrang', weight: 0, width: 15,
                                     height: 4, depth: 6, sku: 'B4TR4NGU3', supplier: supplier)
          # act
          result = product.valid?
          # assert
          expect(result).to eq false
        end

        it 'Altura não pode ser menor que 1' do
          # arrange
          supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                      company_register: '70.190.836/0001-81',
                                      brand_name: 'WayneCorp',
                                      adress: 'Avenida Almirante Barroso, 81',
                                      city: 'Rio de Janeiro', state: 'RJ',
                                      email: 'contato@bwayne.com',
                                      phone_number: '2198405-5854')

          product = ProductModel.new(name: 'Batrang', weight: 1000, width: 20,
                                     height: 0, depth: 6, sku: 'B4TR4NGU3', supplier: supplier)
          # act
          result = product.valid?
          # assert
          expect(result).to eq false
        end

        it 'Largura não pode ser menor que 1' do
          # arrange
          supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                      company_register: '70.190.836/0001-81',
                                      brand_name: 'WayneCorp',
                                      adress: 'Avenida Almirante Barroso, 81',
                                      city: 'Rio de Janeiro', state: 'RJ',
                                      email: 'contato@bwayne.com',
                                      phone_number: '2198405-5854')

          product = ProductModel.new(name: 'Batrang', weight: 1000, width: 0,
                                     height: 4, depth: 6, sku: 'B4TR4NGU3', supplier: supplier)
          # act
          result = product.valid?
          # assert
          expect(result).to eq false
        end

        it 'Profundidade não pode ser menor que 1' do
          # arrange
          supplier = Supplier.create!(company_name: 'Wayne Enterprises Inc',
                                      company_register: '70.190.836/0001-81',
                                      brand_name: 'WayneCorp',
                                      adress: 'Avenida Almirante Barroso, 81',
                                      city: 'Rio de Janeiro', state: 'RJ',
                                      email: 'contato@bwayne.com',
                                      phone_number: '2198405-5854')

          product = ProductModel.new(name: 'Batrang', weight: 1000, width: 15,
                                     height: 4, depth: 0, sku: 'B4TR4NGU3', supplier: supplier)
          # act
          result = product.valid?
          # assert
          expect(result).to eq false
        end
      end
    end
  end
end
