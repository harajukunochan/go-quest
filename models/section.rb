class Section < ApplicationRecord
  belongs_to :quest
  has_many :quest_points, dependent: :destroy
  validates :title, presence: true
end
