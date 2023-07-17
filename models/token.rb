class Token < ApplicationRecord
  belongs_to :user

  after_initialize do |token|
    token.last_use = DateTime.current.beginning_of_day
  end
end
