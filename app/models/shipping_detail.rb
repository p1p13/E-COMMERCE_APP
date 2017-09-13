class ShippingDetail < ApplicationRecord
  belongs_to :user
  validates_presence_of :address_line1, :address_line2, :address_line3, :zip, :country, :state

end
