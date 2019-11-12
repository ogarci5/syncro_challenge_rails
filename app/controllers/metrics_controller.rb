class MetricsController < ApplicationController
  def index
    @metrics = Metric.all.limit(1000)
    render component: 'Metrics', props: { metrics: @metrics }
  end
end
