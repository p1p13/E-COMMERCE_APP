class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    has_one :cart
    has_many :shipping_details
    has_many :orders
    has_secure_password

end
