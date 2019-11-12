class Metric < ApplicationRecord
  scope :categories, ->(first_date = nil, last_date = nil) { distinct.pluck(:category) }
  scope :from_category, ->(category = nil) { where(category: category) }

  validates :category, presence: true
  validates :machine_id, presence: true

  def self.chart_data(category:)
    category ||= self.first.category
    metrics = Metric.from_category(category)
    values = metrics.distinct.pluck(:value)
    values = values.first(10) if values.count > 10
    # This can be optimized in the SQL statement
    # By either grouping and subquerying
    values.map { |value| { name: value, value: metrics.where(value: value).count } }
  end
end
