module Api
  class RouteNotFoundController < ApplicationController
    skip_before_action :verify_authenticity_token

    def route_not_found
      render json: { errors: 'Route not found' }.to_json, status: :not_found
    end
  end
end
