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
    end
  end
end
