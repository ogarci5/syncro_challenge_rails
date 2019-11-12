class Metric < ApplicationRecord
  validate :category, presence: true
  validate :machine_id, presence: true
end
