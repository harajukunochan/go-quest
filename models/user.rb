class User < ApplicationRecord
  has_secure_password
  has_many :token, dependent: :destroy
  has_many :quest, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [156, 156]
  end

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  before_save { self.name = name.downcase }
end
