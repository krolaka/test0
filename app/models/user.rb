class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable
end
