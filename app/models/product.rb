class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  validates_presence_of :title, :description, :in_stock, :cost
  validates :in_stock, numericality: { greater_than_or_equal_to: 0 }
end
