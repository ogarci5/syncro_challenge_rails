class ApiController < ApplicationController
  before_action :ensure_authorization

  private

  def ensure_authorization
    head 403 if params[:key] != ENV['API_KEY']
  end
end
