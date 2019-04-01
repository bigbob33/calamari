require_relative 'current_shift_status/entries'

module Calamari
  module CurrentShiftStatus
    class UnknownErrorCodeError < StandardError; end

    ENDPOINT_PATH = '/clockin/shift/status/v1/get-current-for-all'.freeze

    def get_current_shifts_for_all(_options = {})
      response = self.class.post(
        ENDPOINT_PATH
      )

      raise UnknownErrorCodeError unless response.ok?

      Entries.build(
        response.parsed_response
      )
    end
  end
end
