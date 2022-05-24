require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email'do
      #arrange
      u= User.new(name: 'Teste Testando', email:'teste@testando.com')
      #act
      result = u.description()
      #assert
      expect(result).to eq('Teste Testando - teste@testando.com') 
      
    end





  end

end
