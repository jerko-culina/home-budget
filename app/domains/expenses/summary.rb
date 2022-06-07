module Expenses
  class Summary
    CATEGORIES = [:month, :category]
    attr_reader :user, :summary_by

    def initialize(user:, summary_by: nil)
      @user = user
      @summary_by = CATEGORIES.include?(summary_by.to_sym) ? summary_by.to_sym : CATEGORIES.first
    end

    def all
      connection.execute(sql).map(&:symbolize_keys)
    end

    def sql
      case summary_by.to_s
      when "month" then summary_by_month_sql
      when "category" then summary_by_category_sql
      end
    end

    def connection
      ActiveRecord::Base.connection
    end

    def summary_by_month_sql
      <<-SQL
        SELECT 
          'month' AS kind,
          EXTRACT(MONTH FROM created_at)::integer AS name, 
          sum(amount_cents) AS amount_cents
        FROM expenses
        GROUP BY EXTRACT(MONTH FROM created_at) 
      SQL
    end

    def summary_by_category_sql
      <<-SQL
      SELECT 
        'category' AS kind,
        c.name AS name, 
        t.amount_cents
      FROM (
        SELECT 
          category_id,
          sum(amount_cents) AS amount_cents
        FROM expenses 
        GROUP BY category_id
      ) t
      JOIN categories c ON t.category_id = c.id
      SQL
    end
  end
end