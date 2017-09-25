require 'rails_helper'  

describe ShippingDetail do
  it "has a valid factory" do
     FactoryGirl.build(:valid_user).shipping_details.build(FactoryGirl.attributes_for(:shipping_detail)).should be_valid
  end
  it "is invalid without address line1" do
    FactoryGirl.build(:shipping_detail, address_line1:nil).should_not be_valid
  end
  it "is invalid without address line2" do
    FactoryGirl.build(:shipping_detail, address_line2:nil).should_not be_valid
  end
  it "is invalid without address line3" do
    FactoryGirl.build(:shipping_detail, address_line3:nil).should_not be_valid
  end
  it "is invalid without zip" do
    FactoryGirl.build(:shipping_detail, zip:nil).should_not be_valid
  end
  it "is invalid without country" do
    FactoryGirl.build(:shipping_detail, country:nil).should_not be_valid
  end
  it "is invalid without state" do
    FactoryGirl.build(:shipping_detail, state:nil).should_not be_valid
  end
  it "should have many orsers" do
    t = ShippingDetail.reflect_on_association(:orders)
    expect(t.macro).to eq(:has_many)
  end
  it "should belong to one user" do
    t = ShippingDetail.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end
end