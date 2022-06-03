require "rails_helper"

describe 'CategoriesController', type: :request do
  let(:user) { create(:user) }
  let(:user_categories) { create_list(:category, 2, user: user) }
  let(:gringo_categories) { create_list(:category, 2) }

  describe '#index' do
    before do
      user
      user_categories
      gringo_categories
    end

    it 'returns list of user categories' do
      get '/api/categories', headers: authenticated_headers(user)

      expect(response).to have_http_status(:ok)
      expect(parsed_response.pluck("id")).to match_array(user_categories.pluck(:id))
      expect(parsed_response.pluck("id")).not_to include(gringo_categories.pluck(:id))
    end
  end

  describe '#show' do
    before do
      user
      user_categories
      gringo_categories
    end

    context 'when user owns category' do
      let(:category_id) { user_categories.first.id }

      it 'returns category' do
        get "/api/categories/#{category_id}", headers: authenticated_headers(user)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['id']).to eq(category_id)
      end
    end

    context 'when user does not own category' do
      let(:category_id) { gringo_categories.first.id }

      it 'returns category' do
        get "/api/categories/#{category_id}", headers: authenticated_headers(user)

        expect(response).to have_http_status(:not_found)
        expect(parsed_response["errors"]).to be_present
      end
    end


    context 'when category does not exist' do
      let(:category_id) { SecureRandom.random_number(1000..10000) }

      it 'returns category' do
        get "/api/categories/#{category_id}", headers: authenticated_headers(user)

        expect(response).to have_http_status(:not_found)
        expect(parsed_response["errors"]).to be_present
      end
    end
  end

  describe "#create" do
    context 'when params are valid' do

    end
  end

  describe "#update" do
    context 'when user owns category' do
      it 'updates for valid params'
      it 'does not update for bad or missing params'
    end

    context 'when user does not own category' do
      it 'returns not found'
    end

    context 'when category does not exist' do
      it 'retruns not found'
    end
  end

  describe "delete" do
    context 'when user owns category' do
      context 'when category does not have any expenses' do
        it 'deletes category'
      end

      context 'when category has many expensed' do
        it 'does not delete category'
      end
    end

    context 'when user does not own category' do
      it 'returns not found'
    end

    context 'when category does not exist' do
      it 'retruns not found'
    end
  end
end
