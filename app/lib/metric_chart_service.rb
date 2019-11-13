class MetricChartService
  attr_reader :category, :metrics, :sample, :type, :chartable

  def initialize(category:)
    @category = category
    @metrics = Metric.from_category(category)
    @sample = @metrics.distinct(:value).limit(20)
  end

  def statistics
    determine_type

    case type
    when :distinct
      @metrics.group(:value).count.map { |name, value| { name: name, value: value } }
    when :date, :decimal
      consolidate_totals(series: 5)
    when :unchartable, :regular_version, :semantic_version
      @metrics.limit(10).group(:value).count.map { |name, value| { name: name, value: value } }
    end
  end

  def determine_type
    return @type = :distinct if sample.count < 20

    # If the category is a version
    if category.include?('version')
      return @type = :regular_version if sample.map(&:value).all? { |v| v.match(/\d+\.\d+/) }
      return @type = :semantic_version if sample.map(&:value).all? { |v| v.match(/\d+\.\d+\.\d+/) }
    else
      # TODO do this differently or enforce the type
      return @type = :date if sample.map(&:value).all? { |v| Date.strptime(v, "%Y-%m-%d") rescue false }
      return @type = :decimal unless sample.map(&:value).map(&:to_f).all?(&:zero?)
    end

    @type = :unchartable
  end

  def consolidate_totals(series: 5)
    if type == :date
      dates = @metrics.distinct(:value).limit(100).pluck(:value).map do |value|
        DateTime.strptime(value, "%Y-%m-%d")
      end
      min, max = *dates.map(&:to_i).minmax
      cast_type = 'DATE'
    else
      min, max = *@metrics.distinct(:value).limit(100).pluck(:value).map(&:to_f).minmax
      cast_type = 'DECIMAL'
    end

    step = (max - min) / series.to_f
    (min..max).step(step).each_cons(2).map do |prev, following|
      prev = prev.round(2)
      following = following.round(2)

      if type == :date
        prev = Time.at(prev)
        following = Time.at(following)
        name = "#{prev.strftime("%Y-%m-%d")}-#{following.strftime("%Y-%m-%d")}"
      else
        name = "#{prev}-#{following}"
      end

      # TODO this could be pulled into a group
      { name: name, value: metrics.where("CAST(value AS #{cast_type}) BETWEEN ? AND ?", prev, following).count }
    end
  end
end
