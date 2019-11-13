class Api::EventsController < ApiController
  def index
    @metrics = Metric.where(metric_params)
    total = @metrics.count
    page = params[:page] || 1
    results = @metrics.page(page)

    render json: { status: :success, total: total, page: page, results: results }
  end

  def create
    @metric = Metric.new(metric_params)

    if @metric.save
      render json: { status: :success, results: @metric }
    else
      render json: { status: :error, errors: @metric.errors.full_messages }
    end
  end

  def statistics
    statistics = Metric.statistics(category: metric_params[:category])

    render json: { status: :success, results: statistics }
  end

  private

  def metric_params
    params.permit(:category, :value, :machine_id)
  end
end
