class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :api_key

  validates_uniqueness_of :email
end
