require "rails_helper"

module ParsedResponse
  def parsed_response
    JSON.parse(response.body)
  end
end