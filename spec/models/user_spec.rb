require 'rails_helper'


RSpec.describe User, type: :model do
      
  describe '#name' do
    context 'empty' do
      it 'not valid' do
        user = User.new(name:"",password:"test_password")        
        expect(user).not_to be_valid
      end
    end
    context 'over_UserLimit::NAME' do
      it 'not_valid' do
        user = User.new(name:"a"*UserLimit::NAME+"b",password:"test_password")
        expect(user).not_to be_valid
      end
    end
    context 'within_UserLimit::NAME' do
      it 'valid' do
        user = User.new(name:"a"*UserLimit::NAME,password:"test_password")
        expect(user).to be_valid
      end
    end
    
    context 'not_unique' do
      it 'raise error RecordNotUnique' do
        expect do
          user = User.new(name:"a",password:"test_password")
          user.save!
          user2 = User.new(name:"a",password:"test_password")
          user2.save!
        end.to raise_error(ActiveRecord::RecordInvalid) 
        #raise_error(ActiveRecord::RecordNotUnique)
      end
    end
    
    context 'xxx' do
      let(:user){create(:user)}
      it 'factory_test'do        
        expect(user).to be_valid
      end
    end
    
  end
end
