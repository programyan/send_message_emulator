# frozen_string_literal: true

module Acceptance
  module Helpers
    def json
      JSON.parse(response_body)
    end

    def headers
      {
        'CONTENT_TYPE' => 'application/json',
        'Accept' => 'application/json',
      }
    end
  end
end
