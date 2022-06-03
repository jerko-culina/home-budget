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
      get '/api/expenses', headers: authenticated_headers(user)

      expect(response).to have_http_status(:ok)
      user_expenses = user_expenses_category_1 + user_expenses_category_2
      expect(parsed_response.pluck("id")).to match_array(user_expenses.pluck(:id))
      expect(parsed_response.pluck("id")).not_to include(gringo_expenses.pluck(:id))
    end
  end

  describe "#show" do
    context 'when user owns expense' do
      it 'returns expense'
    end

    context 'when user does not own expense' do
      it 'returns not found'
    end

    context 'when expense does not exist' do
      it 'returns not found'
    end

    # it behaves like 'non authenticated request'
    # it behaves like 'accept header is bad or missing'
    # it behaves ...
  end

  describe "#create" do
    before do
      user
      user_category_1
      gringo_category
    end

    context 'when params are valid' do
      let(:valid_params) do
        { expense: {
          title: "My first expense",
          amount_cents: 100,
          category_id: user_category_1.id
        }}.to_json
      end

      it 'creates expense' do
        post '/api/expenses', headers: authenticated_headers(user), params: valid_params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there is no enoguh money' do
      
    end

    context 'when params are invalid' do
      context 'when user does not own expense cateogry' do
        let(:invalid_params) do
          { expense: {
            title: "My first expense",
            amount_cents: 100,
            category_id: gringo_category.id
          }}.to_json
        end

        it 'fails' do
          post '/api/expenses', headers: authenticated_headers(user), params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)  
        end
      end

      #...
    end
  end


end