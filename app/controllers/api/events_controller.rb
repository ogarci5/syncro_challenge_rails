class Api::EventsController < ApplicationController
  def index
    @metrics = Metric.where(**metric_params)
    total = @metrics.count
    page = params[:page] || 0
    results = @metric.page(page)

    render json: { total: total, page: page, results: results }
  end

  def create
    @metric = Metric.new(metric_params)

    if @metric.save
      render json: { status: :success, event: @metric }
    else
      render json: { status: :error, errors: @metric.errors.full_messages }
    end
  end

  private

  def metric_params
    params.permit(:category, :value, :machine_id, :page)
  end
end
