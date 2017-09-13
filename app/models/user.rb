class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
    has_one :cart
    has_many :shipping_details
    has_many :orders
    has_secure_password
    validates_presence_of :contact_number, on: :update
    validates_presence_of :country_code, on: :update




end
