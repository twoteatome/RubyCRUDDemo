class User < ApplicationRecord
  has_secure_password

  has_many :order
  has_many :product, :dependent => :destroy
end
