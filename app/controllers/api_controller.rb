class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :ensure_authorization

  private

  def ensure_authorization
    head 403 if api_key != ENV['API_KEY']
  end

  def api_key
    params[:key] || request.headers['X-API-Key']
  end
end
