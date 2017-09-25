require 'rails_helper'  

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:valid_user).should be_valid
  end
  it "is invalid without email" do
    FactoryGirl.build(:valid_user, email:nil).should_not be_valid
  end
  it "is a invalid without proper email format" do
    FactoryGirl.build(:valid_user, email:"abc@xyz.").should_not be_valid
  end
  it "is invalid without unique email" do
    FactoryGirl.create(:valid_user)
    FactoryGirl.build(:valid_user).should_not be_valid
  end
  it "is invalid without password" do
    FactoryGirl.build(:valid_user, password:nil).should_not be_valid
  end
  it "is invalid without contact number" do
    FactoryGirl.create(:valid_user, contact_number:nil).should_not be_valid
  end
  it "is invalid without country code" do
    FactoryGirl.create(:valid_user, country_code:nil).should_not be_valid
  end
  it "does not store password in database" do
    FactoryGirl.create(:valid_user)
    User.last.password.should == nil
  end
  it "stores password in memory" do
    user = FactoryGirl.create(:valid_user)
    user.password.should == FactoryGirl.attributes_for(:valid_user)[:password]
  end
end