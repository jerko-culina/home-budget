module Expenses
  class Creator
    def self.permitted_params
      [:title, :amount_cents, :category_id]
    end

    attr_reader :user, :expense
    def initialize(user:)
      @user = user
    end

    def expense
      @expense ||= Expense.new
    end

    def create_expense(params)
      expense.category = Categories::Finder.new(user: user).find_by(id: params[:category_id])

      expense.assign_attributes(params.except(:category_id))
      
      return false unless check_for_available_amount
      return false unless expense.valid?
      
      ActiveRecord::Base.transaction do
        # race condition still possible
        # in postgres there are better ways to implement this
        expense.save
        user.save
      end
    end

    def check_for_available_amount
      return true if user.available_cents >= expense.amount_cents

      expense.errors.add(:base, "Not enoguh available money")
      false
    end
  end
end