class MetricsController < ApplicationController
  def index
    @metrics = Metric.from_category(params[:category]).page(params[:page])
    @metrics_component = {
      categories: Metric.categories,
      category: params[:category] || '',
      data: @metrics.chart_data(category: params[:category])
    }
  end
end
