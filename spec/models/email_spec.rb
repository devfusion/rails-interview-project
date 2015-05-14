require 'spec_helper'
 
describe Email, :type => :model do
  
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end
 
  describe 'Validations' do
    context "address should be present" do
      it { is_expected.to validate_presence_of(:address) }
    end
  end

end