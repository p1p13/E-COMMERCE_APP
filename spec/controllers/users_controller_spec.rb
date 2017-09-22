require 'rails_helper'  
RSpec.describe UsersController do
  before(:each) do |example|
    unless example.metadata[:skip_before]
      post :create, params: { user: FactoryGirl.attributes_for(:dummy_user1) }
      post :create, params: { user: FactoryGirl.attributes_for(:dummy_user2) }
    end
  end
  describe "GET #new", :skip_before  do
    it "renders the new view  " do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" , :skip_before do
    context "with valid attributes" do
      it "creates a new user and doesn't create duplicate user" do
        expect{
          post :create, params: { user: FactoryGirl.attributes_for(:user) }
        }.to change(User,:count).by(1)
        expect{
          post :create, params: { user: FactoryGirl.attributes_for(:user) }
        }.to_not change(User,:count)
      end

      it "redirects to profile page" do
        post :create, params: { user: FactoryGirl.attributes_for(:user) }
        response.should redirect_to edit_profile_users_path
      end
    end

    context "with invalid attributes" do
      it "does not creates a new user" do
        expect{
          post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) }
        }.to_not change(User,:count)
      end

      it "redirects to profile page" do
        post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) }
        response.should render_template :new
      end
    end
  end

  describe "GET #edit_profile" do
    it "renders the edit_profile view " do
      get :edit_profile
      response.should render_template :edit_profile
    end
  end

  describe "GET #show" do
    before(:each) do
      User.last.toggle!(:admin)
    end
    it "allows admin to render the show view" do
      get :show, params: {id: User.first.id}
      response.should render_template :show
    end
    it "assigns the user in context to @user" do
      get :show, params: {id: User.first.id}
      assigns(:user).should eq(User.first)  
    end
  end

  describe "PATCH #update_profile" do
    it "redirects to root url" do
      patch :update_profile, params: { user: FactoryGirl.attributes_for(:valid_user) }
      response.should redirect_to root_url
    end
  end

  describe "GET #index" do
    it "should redirect to root for non-admin" do
      get :index
      response.should redirect_to :root
    end
    it "renders the index view for admin" do
      User.last.toggle!(:admin)
      get :index
      response.should render_template :index
    end 
    it "gives list of all users in database for admin" do
      User.last.toggle!(:admin)
      get :index
      assigns(:users).should eq(User.all)  
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      User.last.toggle!(:admin)
    end
    it "allows the admin to delete users" do
      expect{
        delete :destroy, params: {id: User.first.id}
      }.to change(User, :count).by(-1)
    end
  end
end