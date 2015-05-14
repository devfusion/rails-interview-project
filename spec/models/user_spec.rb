require 'spec_helper'
 
describe User, :type => :model do
 
  describe 'Associations' do
    it { is_expected.to belong_to(:group) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:emails) }
  end
 
  describe 'Validations' do
    [:name].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

end