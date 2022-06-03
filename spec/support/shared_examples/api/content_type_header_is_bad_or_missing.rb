RSpec.shared_examples 'content-type header is bad or missing' do |method, path, **kwargs|
  it 'returns not found' do
    headers = kwargs[:headers] || default_headers.except("Content-Type", "content-type", "CONTENT-TYPE")

    send method, path
    
    expect(response).to have_http_status(:bad_request)
    expect(parsed_response["errors"]).to eq("Request Content-Type header has to be: application/json")
  end
end