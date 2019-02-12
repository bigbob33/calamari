require_relative 'absence_requests/entries'

module Calamari
  module AbsenceRequests
    ENDPOINT_PATH = '/leave/request/v1/find'.freeze

    def absence_requests_find(options = {})
      response = self.class.post(
          ENDPOINT_PATH,
          body: options.to_json
      )

      Entries.build(
          response.parsed_response
      )
    end
  end
end