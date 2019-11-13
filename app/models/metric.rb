class Metric < ApplicationRecord
  scope :categories, ->(first_date = nil, last_date = nil) { distinct.pluck(:category) }
  scope :from_category, ->(category = nil) { where(category: category) }

  validates :category, presence: true
  validates :machine_id, presence: true

  def self.statistics(category:)
    category ||= self.first.category
    metrics = Metric.from_category(category)
    values = metrics.distinct.pluck(:value)

    # This can be optimized in the SQL statement
    # By either grouping and subquerying
    if values.count > 10
      # if these values are strings that cannot be coerced into numbers just return a sample of the results
      if values.first(10).map(&:to_f).all?(&:zero?)
        values = values.first(10)
        values.map { |value| { name: value, value: metrics.where(value: value).count } }
      else
        min, max = *values.map(&:to_f).minmax
        series = 5.0
        step = (max - min) / series
        (min..max).step(step).each_cons(2).map do |prev, following|
          prev = prev.round(2)
          following = following.round(2)
          name = "#{prev}-#{following}"
          { name: name, value: metrics.where("CAST(value AS DECIMAL) BETWEEN ? AND ?", prev, following).count }
        end
      end

    else
      values.map { |value| { name: value, value: metrics.where(value: value).count } }
    end
  end
end
