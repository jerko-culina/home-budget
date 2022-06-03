require "rails_helper"

describe 'RegistrationsController', type: :request do

  describe "#create" do
    let(:valid_registration_params) do 
      {
        user: {
          email: "user1@example.com",
          password: "thisisvalidpassword",
          password_confirmation: "thisisvalidpassword"
        }
      }.to_json
    end

    context 'when registration params are valid' do

      it 'returns auth token' do
        expect do
          post '/api/registrations', headers: default_headers, params: valid_registration_params
        end.to change(User, :count).by(1)
      
        expect(response).to have_http_status(:created)
        expect(parsed_response["auth_token"]).to be_present
      end
    end

    context 'when email is bad or missing' do
      let(:email_missing_params) do
        { 
          user: {
            password: "this is valid password"
          }
        }.to_json
      end

      let(:bad_email_params) do
        { 
          user: {
            email: 'thisisnotemail',
            password: "this is valid password"
          }
        }.to_json
      end

      it 'fails for missing email' do
        expect do
          post '/api/registrations', headers: default_headers, params: email_missing_params
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response["errors"]).to be_present
      end

      it 'fails for bad email' do
        expect do
          post '/api/registrations', headers: default_headers, params: bad_email_params
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response["errors"]).to be_present
      end
    end

    context 'when email has already been taken' do
      let(:email) { "alreadytaken@example.com" }
      before do
        create(:user, email: email)
      end

      let(:already_taken_email_params) do
        {
          user: {
            email: email,
            password: "thisisvalidpassword"
          }
        }.to_json
      end

      it 'fails for not unique email' do
        expect do
          post '/api/registrations', headers: default_headers, params: already_taken_email_params
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response["errors"]).to be_present
        expect(parsed_response["errors"]).not_to include("Email has already been taken")
      end
    end

    context 'when password is bad or missing' do
      let(:short_password_params) do
        {
          user: {
            email: "user1@example.com",
            password: "short"
            }
          }.to_json
      end

      let(:password_missing_params) do
        {
          user: {
            email: "user1@example.com"
            }
          }.to_json
      end

      it 'fails for missing password' do
        expect do
          post '/api/registrations', headers: default_headers, params: password_missing_params
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response["errors"]).to be_present
      end

      it 'fails for too short password' do
        expect do
          post '/api/registrations', headers: default_headers, params: short_password_params
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response["errors"]).to be_present
      end
    end
  end

  it_behaves_like "endpoint has not been exposed", :get, '/api/registrations'
  it_behaves_like "endpoint has not been exposed", :get, '/api/registrations/new'
  it_behaves_like "endpoint has not been exposed", :get, '/api/registrations/1'
  it_behaves_like "endpoint has not been exposed", :put, '/api/registrations'
  it_behaves_like "endpoint has not been exposed", :patch, '/api/registrations'
  it_behaves_like "endpoint has not been exposed", :delete, '/api/registrations/1'

  it_behaves_like "accept header is bad or missing", :post, '/api/registrations'
  it_behaves_like "content-type header is bad or missing", :post, '/api/registrations'
end