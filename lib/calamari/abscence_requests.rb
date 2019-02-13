require_relative 'absence_requests/entries'

module Calamari
  module AbsenceRequests
    class InvalidEmployeeError < StandardError; end
    class InvalidDateFromError < StandardError; end
    class InvalidDateToError < StandardError; end
    class UnknownErrorCodeError < StandardError; end

    ENDPOINT_PATH = '/leave/request/v1/find'.freeze

    INVALID_EMPLOYEE_CODE = 'INVALID_EMPLOYEE'.freeze
    INVALID_DATE_FROM_CODE = 'INVALID_DATE_FROM'.freeze
    INVALID_DATE_TO_CODE = 'INVALID_DATE_TO'.freeze

    def absence_requests_find(options = {})
      response = self.class.post(
          ENDPOINT_PATH,
          body: options.to_json
      )
      if response.ok?
        Entries.build(
            response.parsed_response
        )
      else
        case response.parsed_response['code']
        when INVALID_EMPLOYEE_CODE then raise InvalidEmployeeError
        when INVALID_DATE_FROM_CODE then raise InvalidDateFromError
        when INVALID_DATE_TO_CODE then raise InvalidDateToError
        else raise UnknownErrorCodeError
        end
      end
    end
  end
end