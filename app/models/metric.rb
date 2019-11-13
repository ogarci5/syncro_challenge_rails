class Metric < ApplicationRecord
  scope :categories, ->(first_date = nil, last_date = nil) { distinct.pluck(:category) }
  scope :from_category, ->(category = nil) { where(category: category) }

  validates :category, presence: true
  validates :machine_id, presence: true

  def self.statistics(category: nil)
    return [] if category.blank?

    service = MetricChartService.new(category: category)
    service.statistics
  end
end
