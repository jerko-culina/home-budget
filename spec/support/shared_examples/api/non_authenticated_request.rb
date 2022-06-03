RSpec.shared_examples 'non authenticated request' do |method, path, **kwargs|
  it 'returns unauthorized' do
    headers = kwargs.fetch(headers, default_headers)
                    .except("Authorization", "authorization", "AUTHORIZATION")
    
    send method, path, headers: headers

    expect(response).to have_http_status(:unauthorized)
    expect(parsed_response["errors"]).to eq("Unauthorized")
  end
end