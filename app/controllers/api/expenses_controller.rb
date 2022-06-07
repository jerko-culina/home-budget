module Api
  class ExpensesController < AuthenticatedController
    def index
      expenses = ::Expenses::Finder.new(user: current_user).all
      respond_with expenses, serializer: Api::ExpensesSerializer
    end

    def show
      expense = ::Expenses::Finder.new(user: current_user).find(params[:id])
      respond_with expense, serializer: Api::ExpensesSerializer
    end

    def create
      creator = ::Expenses::Creator.new(user: current_user)
      
      creator.create_expense(create_params)

      respond_with creator.expense, serializer: Api::ExpensesSerializer
    end

    def update
      expense = ::Expenses::Finder.new(user: current_user).find(params[:id])

      updater = ::Expenses::Updater.new(user: current_user, expense: expense)

      updater.update_expense(update_params)

      respond_with updater.expense, serializer: Api::ExpensesSerializer
    end

    private

    def create_params
      params.require(:expense).permit(::Expenses::Creator.permitted_params)
    end

    def update_params
      params.require(:expense).permit(::Expenses::Updater.permitted_params)
    end
  end
end