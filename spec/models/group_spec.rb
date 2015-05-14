require 'rails_helper'

describe Group do
  before do
    @group = FactoryGirl.build(:group)
  end

  it "has a valid factory" do
    expect(@group).to be_valid
  end

end