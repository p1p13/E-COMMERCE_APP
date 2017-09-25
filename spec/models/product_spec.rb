require 'rails_helper'  

describe Product do
  it "has a valid factory" do
    FactoryGirl.build(:product).should be_valid
  end
  it "is invalid without title" do
    FactoryGirl.build(:product, title: nil).should_not be_valid
  end
  it "is a invalid without description" do
    FactoryGirl.build(:product, description: nil).should_not be_valid
  end
  it "is invalid without instock" do
    FactoryGirl.create(:product)
    FactoryGirl.build(:product, in_stock:nil).should_not be_valid
  end
  it "is invalid without cost" do
    FactoryGirl.build(:product, cost:nil).should_not be_valid
  end
  it "should have many cart items" do
    t = Product.reflect_on_association(:cart_items)
    expect(t.macro).to eq(:has_many)
  end
  it "should have many order items" do
    t = Product.reflect_on_association(:order_items)
    expect(t.macro).to eq(:has_many)
  end
end