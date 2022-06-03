RSpec.shared_examples 'endpoint has not been exposed' do |method, path|
  it 'returns not found' do
    send method, path

    expect(response).to have_http_status(:not_found)
    expect(parsed_response["errors"]).to eq("Route not found")
  end
end