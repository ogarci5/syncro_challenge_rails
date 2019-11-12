class Metric < ApplicationRecord
  scope :categories, ->(first_date = nil, last_date = nil) { distinct.pluck(:category) }
  scope :from_category, ->(category = nil) { where(category: category) }

  validates :category, presence: true
  validates :machine_id, presence: true

  def self.chart_data(category:)
    category ||= self.first.category
    metrics = self.all.select { |metric| metric.category == category }.uniq
    metrics.map(&:value).uniq.map { |value| { name: value, value: metrics.select { |m| m.value == value }.count } }
  end
end
