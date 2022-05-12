require 'rails_helper'
RSpec.describe Supplier, type: :model do
  describe '#valid?' do

    context 'cadastro de novo fornecedor' do
      it 'falso quando o nome da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                    city:'Tatuapé', state:'SP', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o CPNJ da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                    city:'Tatuapé', state:'SP', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o nome fantasia da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'', adress:'Rua Vilela, 663',
                    city:'Tatuapé', state:'SP', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o endereço da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'',
                    city:'Tatuapé', state:'SP', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando a cidade da empresa está vazia' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                    city:'', state:'SP', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o estado da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                    city:'Tatuapé', state:'', 
                    email:'contato@tstark.com', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o email da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                    city:'Tatuapé', state:'SP', 
                    email:'', phone_number:'6799672-3406')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o telefone da empresa está vazio' do
        #Arrange
        supplier = Supplier.new(company_name:'Stark Technology Inc', 
                    company_register:'00.178.762/0001-82',
                    brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                    city:'Tatuapé', state:'SP', 
                    email:'contato@tstark.com', phone_number:'')
        #Act
            result = supplier.valid?
        #Assert
        expect(supplier.valid?).to eq false
      end
    end #end do context

    it 'falso quando um CPNJ já está em uso' do
      #arrange
      first_supplier = Supplier.create(company_name:'Stark Technology Inc', 
                        company_register:'00.178.762/0001-82',
                        brand_name:'Stark Industries', adress:'Rua Vilela, 663',
                        city:'Tatuapé', state:'SP', 
                        email:'contato@tstark.com', phone_number:'6799672-3406')

      second_supplier = Supplier.new(company_name:'Wayne Enterprises Inc', 
                  company_register:'00.178.762/0001-82',
                  brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
                  city:'Rio de Janeiro', state:'RJ',
                  email:'contato@bwayne.com', phone_number:'4398405-5854')
      #act
        result = second_supplier.valid?
      #assert
      expect(result).to eq false
    end

    it 'falso quando o CPNJ está no formato inválido' do
      #Arrange
      supplier = Supplier.new(company_name:'Wayne Enterprises Inc', 
        company_register:'00178762000182',
        brand_name:'WayneCorp',adress:'Avenida Almirante Barroso, 81',
        city:'Rio de Janeiro', state:'RJ',
        email:'contato@bwayne.com', phone_number:'4398405-5854')
      #Act
      result = supplier.valid?
      #Assert
      expect(result).to eq false
    end

  end #end do describe
end #end do RSpec.describe