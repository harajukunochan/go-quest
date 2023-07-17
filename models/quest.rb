class Quest < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_many :quest_points, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [156, 156]
  end

  validates :title, presence: true
end
