require 'rails_helper'

describe GroupsController do
  
  before do 
    @group = FactoryGirl.create(:group)
  end

  describe 'responce of each action' do
    describe 'GET#index' do
      it 'returns groups data object' do
        get :index
        byebug
        expect(response.body).to eq()
      end
    end
  end
end