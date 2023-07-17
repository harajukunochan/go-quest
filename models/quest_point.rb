class QuestPoint < ApplicationRecord
  belongs_to :quest
  belongs_to :section, optional: true
  has_many_attached :images

  validates :title, presence: true
end
