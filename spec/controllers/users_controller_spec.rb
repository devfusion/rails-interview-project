require 'rails_helper'
describe UsersController, :type => :controller do
  before do
    @group = FactoryGirl.create(:group)
    @user = FactoryGirl.create(:user, group_id: @group.id)
    @email = FactoryGirl.create(:email, user_id: @user.id)
    @group2 = FactoryGirl.create(:group)
  end

  describe "GET #show" do
    it 'responds successfully with an HTTP 200 status code' do
      get :show, group_id: @group.id, id: @user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, group_id: @group.id, id: @user.id
      expect(response).to render_template("show")
    end

    it "loads group based on group id" do
      get :show, group_id: @group.id, id: @user.id
      expect(assigns(:group)).to match(@group)
    end

    it "loads user based on user id in a group" do
      get :show, group_id: @group.id, id: @user.id
      expect(assigns(:user)).to match(@user)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, group_id: @group.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new, group_id: @group.id
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user in a group" do
        expect(response).to be_success
      end

      it "redirect to groups show path after successful create" do
        params = {"user" => {"name"=>"user1", "emails_attributes"=>{"1431622843355"=>{"address"=>"user1@mailinator.com"}}}}
        expect{post :create, params.merge(group_id: @group.id)}.to change(Group, :count).by(0)
        expect{post :create, params.merge(group_id: @group.id)}.to change(User, :count).by(1)
        expect{post :create, params.merge(group_id: @group.id)}.to change(Email, :count).by(1)
        expect(response).to redirect_to(group_path(@group))
      end
    end
    
    context "with invalid params" do
      it "it render new template if group failed to create" do
        params = {"user" => {"name"=>"user1", "emails_attributes"=>{"1431622843355"=>{"address"=>"user1c.mailinatr.com"}}}}
        post :create, params.merge(group_id: @group.id)
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "render an edit template" do
      get :edit, group_id: @group.id, id: @user.id
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    it 'updates a given user' do
      params = {"user" => {"name" => 'Edited User'}}
      put :update, params.merge(group_id: @group.id, id: @user.id)
      expect(assigns(:user).name).to eq('Edited User')
    end

    it 'redirect to groups show path after update' do
      params = {"user" => {"name" => 'Edited User'}}
      put :update, params.merge(group_id: @group.id, id: @user.id)
      expect(response).to redirect_to(group_path(@group))
    end
  end

  describe 'Delete destroy' do
    it 'deleted a particular user from DB' do
      expect{delete :destroy, group_id: @group.id, id: @user.id}.to change(Group, :count).by(0)
    end

    it 'deleted a particular user of a group from DB' do
      expect{delete :destroy, group_id: @group.id, id: @user.id}.to change(User, :count).by(-1)
    end

    it 'deleted a particular email of a user of group from DB' do
      expect{delete :destroy, group_id: @group.id, id: @user.id}.to change(Email, :count).by(-1)
    end
  end
end