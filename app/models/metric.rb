class Metric < ApplicationRecord
  validates :category, presence: true
  validates :machine_id, presence: true
end
