require 'rails_helper'  

describe Cart do
  it "should have many cart items" do
    t = Cart.reflect_on_association(:cart_items)
    expect(t.macro).to eq(:has_many)
  end
  it "should belong to one user" do
    t = Cart.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end
end