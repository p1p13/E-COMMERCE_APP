class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_details, optional: true
  has_many :order_items
end
