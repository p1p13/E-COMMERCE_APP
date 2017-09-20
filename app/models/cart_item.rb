class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, numericality: { greater_than: 0 }
  validates_presence_of :product_id

end
