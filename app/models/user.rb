class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :in_messages, class_name: 'Message', foreign_key: :rxuser_id
  has_many :out_messages, class_name: 'Message', foreign_key: :txuser_id

  validates :username, presence: true, length: { maximum: 64 }, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create, :update]}, uniqueness: true

  def admin?
    admin
  end

end
