module Expenses
  class Updater
    def self.permitted_params
      [:title, :category_id]
    end
    
    attr_reader :user, :expense

    def initialize(user:, expense:)
      @user = user
      @expense = expense
    end
    
    def update_expense(params)
      if params[:category_id]
        expense.category = Categories::Finder.new(user: user).find_by(id: params[:category_id])
      end
      expense.assign_attributes(params.except(:category_id))
      expense.save
    end
  end
end