class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_details, optional: true
  has_many :order_items, dependent: :destroy
  validates_presence_of :payment_mode,  :shipping_details_id
end
