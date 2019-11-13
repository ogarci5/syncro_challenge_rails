class MetricsController < ApplicationController
  def index
    @metrics = Metric.from_category(params[:category]).page(params[:page])
    @metrics_component = {
      categories: Metric.categories,
      category: params[:category] || '',
      data: Metric.statistics(category: params[:category])
    }
  end
end
