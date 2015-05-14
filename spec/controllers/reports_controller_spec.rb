require 'rails_helper'
describe ReportsController, :type => :controller do
  before do
    @group = FactoryGirl.create(:group)
    @user = FactoryGirl.create(:user, group: @group)
    @email = FactoryGirl.create(:email, user: @user)
    @user1 = FactoryGirl.create(:user, group: @group)
    @email1 = FactoryGirl.create(:email, user: @user1)
    
    @group2 = FactoryGirl.create(:group)
    @user2 = FactoryGirl.create(:user, group: @group2)
    @email2 = FactoryGirl.create(:email, user: @user2)
    @groups = Group.all
  end

  describe "GET #index" do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the groups into @groups" do
      get :index
      expect(assigns(:groups)).to match_array([@group, @group2])
    end
  end

  describe "GET #all_reports" do
    it 'responds successfully with an HTTP 200 status code' do
      get :all_reports
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the JSON result for all groups in DB" do
      get :all_reports
      expect(response.body).to eq(@groups.to_json(:only => :name, :include => [:users => {:only => :name, :include => [:emails => {:only => :address}]}]))
    end
  end

  describe "GET #group_reports" do
    it 'responds successfully with an HTTP 200 status code' do
      get :group_reports, id: @group.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the JSON result for perticular groups in DB" do
      get :group_reports, id: @group.id
      expect(response.body).to eq(@group.to_json(:only => :name, :include => [:users => {:only => :name, :include => [:emails => {:only => :address}]}]))
    end
  end
end