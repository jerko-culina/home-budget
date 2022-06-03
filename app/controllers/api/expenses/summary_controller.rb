module Api
  module Expenses
    class SummaryController < AuthenticatedController
      def index 
        summary = ::Expenses::Summary.new(user: current_user, summary_by: params[:summary_by]).all
        respond_with summary, serializer: Api::Expenses::SummarySerializer
      end
    end
  end
end