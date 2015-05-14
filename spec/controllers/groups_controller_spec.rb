require 'rails_helper'
describe GroupsController, :type => :controller do
  before do
    @group = FactoryGirl.create(:group)
    @user = FactoryGirl.create(:user, group_id: @group.id)
    @email = FactoryGirl.create(:email, user_id: @user.id)
    @group2 = FactoryGirl.create(:group)
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

  describe "GET #show" do
    it 'responds successfully with an HTTP 200 status code' do
      get :show, id: @group.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, id: @group.id
      expect(response).to render_template("show")
    end

    it "loads group based on group id" do
      get :show, id: @group.id
      expect(assigns(:group)).to match(@group)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new group" do
        expect(response).to be_success
      end

      it "it redirect to root path after successful create" do
        params = {"group"=>{"name"=>"group1", "users_attributes"=>{"1431622834187"=>{"name"=>"user1", "emails_attributes"=>{"1431622843355"=>{"address"=>"user1@mailinator.com"}}}}}}
        expect{post :create, params}.to change(Group, :count).by(1)
        expect{post :create, params}.to change(User, :count).by(1)
        expect{post :create, params}.to change(Email, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
    end
    
    context "with invalid params" do
      it "it render new template if group failed to create" do
        params = {"group"=>{"name"=>"", "users_attributes"=>{"1431622834187"=>{"name"=>"user1", "emails_attributes"=>{"1431622843355"=>{"address"=>"user1@mailinator.com"}}}}}}
        post :create, params
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "render an edit template" do
      get :edit, id: @group.id
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    it 'updates a given group' do
      params = {"group" => {"name" => 'Edited Group'}}
      put :update, params.merge(id: @group.id)
      expect(assigns(:group).name).to eq('Edited Group')
    end

    it 'redirect to index after update' do
      params = {"group" => {"name" => 'Edited Group'}}
      put :update, params.merge(id: @group.id)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'Delete destroy' do
    it 'deleted a particular group from DB' do
      expect{delete :destroy, id: @group.id}.to change(Group, :count).by(-1)
    end

    it 'deleted a particular user of a group from DB' do
      expect{delete :destroy, id: @group.id}.to change(User, :count).by(-1)
    end

    it 'deleted a particular email of a user of group from DB' do
      expect{delete :destroy, id: @group.id}.to change(Email, :count).by(-1)
    end
  end
end