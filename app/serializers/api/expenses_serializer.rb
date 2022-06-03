module Api
  class ExpensesSerializer < Blueprinter::Base
    field :id
    field :title
    field :amount
    field :category_id
  end
end