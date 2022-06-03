require "rails_helper"

describe 'ExpensesController', type: :request do
  let(:user) { create(:user) }
  let(:user_category_1) { create(:category, user: user) }
  let(:user_category_2) { create(:category, user: user) }
  let(:gringo_category) { create(:category) }

  let(:user_expenses_category_1) { create_list(:expense, 2, category: user_category_1) }
  let(:user_expenses_category_2) { create_list(:expense, 2, category: user_category_2) }
  let(:gringo_expenses) { create_list(:expense, 2, category: gringo_category) }

  describe '#index' do
    before do
      user
      user_category_1
      user_category_2
      user_expenses_category_1
      user_expenses_category_2
      gringo_category
      gringo_expenses
    end

    it 'returns list of user categories' do
      get '/api/expenses/summary', headers: authenticated_headers(user)

      expect(response).to have_http_status(:ok)
    end
  end
end
