RSpec.shared_examples 'accept header is bad or missing' do |method, path, **kwargs|
  it 'returns not found' do
    headers = kwargs[:headers] || default_headers.except("Accept", "accept", "ACCEPT")
    
    send method, path, headers: headers
    
    expect(response).to have_http_status(:bad_request)
    expect(parsed_response["errors"]).to eq("Request Accept header has to be: application/json")
  end
end