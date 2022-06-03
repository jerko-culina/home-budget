module Api
  class RouteNotFoundController < ApplicationController
    def route_not_found
      render json: { errors: 'Route not found' }.to_json, status: :not_found
    end
  end
end
