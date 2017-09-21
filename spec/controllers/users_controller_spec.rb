require 'rails_helper'  
require 'factory_girl_rails'
RSpec.describe UsersController do
  describe "GET #new" do
    it "renders the new view  " do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect{
          post :create, params: { user: FactoryGirl.attributes_for(:user) }
        }.to change(User,:count).by(1)
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
end