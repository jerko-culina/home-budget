module Api
  module Expenses
    class SummarySerializer < Blueprinter::Base
      field :kind 
      field :amount do |object|
        Money.from_cents(object[:amount_cents]).to_s
      end

      field :name do |object|
        name = object[:name]
        return name if name.is_a?(String)

        Date::MONTHNAMES[name]
      end
    end
  end
end