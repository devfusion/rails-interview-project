require 'spec_helper'
 
describe Group, :type => :model do
 
  describe 'Associations' do
    it { is_expected.to have_many(:users) }
  end
 
  describe 'Validations' do
    [:name].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

end