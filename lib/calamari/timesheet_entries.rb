require_relative 'errors'
require_relative 'timesheet_entries/entries'

module Calamari
  module TimesheetEntries
    include Calamari::Errors
    class InvalidFormData < StandardError; end
    class UnknownErrorCodeError < StandardError; end

    ENDPOINT_PATH = '/clockin/timesheetentries/v1/find'.freeze

    INVALID_FORM_DATA_CODES = [
      INVALID_DATE_FROM_CODE,
      INVALID_DATE_TO_CODE,
      INVALID_EMPLOYEE_CODE,
      INVALID_TEAM_CODE,
      INVALID_POSITION_CODE,
      INVALID_CONTRACT_TYPE_CODE
    ].freeze

    def timesheet_entries_find(options = {})
      response = self.class.post(
        ENDPOINT_PATH,
        body: options.to_json
      )

      raise UnknownErrorCodeError unless response.ok?

      Entries.build(
        response.parsed_response
      )
    end

    private

    def handle_errors(code)
      raise UnknownErrorCodeError unless INVALID_FORM_DATA_CODES.include?(code)

      raise InvalidFormData, "Invalid form data! Code: #{code}"
    end
  end
end