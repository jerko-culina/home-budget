module Expenses
  class Finder
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def find(id)
      all.find(id)
    end

    def all
      Expense.where(category_id: Categories::Finder.new(user: user).all)
    end
  end
end