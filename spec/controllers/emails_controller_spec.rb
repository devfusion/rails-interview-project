require 'rails_helper'
describe EmailsController, :type => :controller do
  before do
    @group = FactoryGirl.create(:group)
    @user = FactoryGirl.create(:user, group_id: @group.id)
    @email = FactoryGirl.create(:email, user_id: @user.id)
    @group2 = FactoryGirl.create(:group)
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, group_id: @group.id, user_id: @user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new, group_id: @group.id, user_id: @user.id
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user in a group" do
        expect(response).to be_success
      end

      it "redirect to groups show path after successful create" do
        params = {"email"=>{"address"=>"user1@mailinator.com"}}
        expect{post :create, params.merge(group_id: @group.id, user_id: @user.id)}.to change(Group, :count).by(0)
        expect{post :create, params.merge(group_id: @group.id, user_id: @user.id)}.to change(User, :count).by(0)
        expect{post :create, params.merge(group_id: @group.id, user_id: @user.id)}.to change(Email, :count).by(1)
        expect(response).to redirect_to(group_user_path(@group, @user))
      end
    end
    
    context "with invalid params" do
      it "it render new template if group failed to create" do
        params = {"email"=>{"address"=>"user1@mailinatorcom"}}
        post :create, params.merge(group_id: @group.id, user_id: @user.id)
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "render an edit template" do
      get :edit, group_id: @group.id, user_id: @user.id, id: @email.id
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    it 'updates a given users email id' do
      params = {"email"=>{"address"=>"user1@mailinator.com"}}
      put :update, params.merge(group_id: @group.id, user_id: @user.id, id: @email.id)
      expect(assigns(:email).address).to eq('user1@mailinator.com')
    end

    it 'redirect to groups show path after update' do
      params = {"email"=>{"address"=>"user1@mailinator.com"}}
      put :update, params.merge(group_id: @group.id, user_id: @user.id, id: @email.id)
      expect(response).to redirect_to(group_user_path(@group, @user))
    end
  end

  describe 'Delete destroy' do
    it 'deleted a particular email of user from DB' do
      expect{delete :destroy, group_id: @group.id, user_id: @user.id, id: @email.id}.to change(Group, :count).by(0)
    end

    it 'deleted a particular user of a group from DB' do
      expect{delete :destroy, group_id: @group.id, user_id: @user.id, id: @email.id}.to change(User, :count).by(0)
    end

    it 'deleted a particular email of a user of group from DB' do
      expect{delete :destroy, group_id: @group.id, user_id: @user.id, id: @email.id}.to change(Email, :count).by(-1)
    end
  end
end