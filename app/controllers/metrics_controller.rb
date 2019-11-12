class MetricsController < ApplicationController
  def index
    @metrics = Metric.all.limit(1000)
    render component: 'Metrics', props: {
      categories: Metric.categories,
      category: params[:category] || '',
      data: @metrics.chart_data(category: params[:category])
    }
  end
end
