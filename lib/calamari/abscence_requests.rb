require_relative 'absence_requests/entries'

module Calamari
  module AbsenceRequests
    class InvalidFormData < StandardError; end
    class UnknownErrorCodeError < StandardError; end

    FIND_ENDPOINT_PATH = '/leave/request/v1/find'.freeze
    FIND_ADVANCED_ENDPOINT_PATH = '/leave/request/v1/find-advanced'.freeze

    INVALID_EMPLOYEE_CODE = 'INVALID_EMPLOYEE'.freeze
    INVALID_DATE_FROM_CODE = 'INVALID_DATE_FROM'.freeze
    INVALID_DATE_TO_CODE = 'INVALID_DATE_TO'.freeze
    INVALID_ABSENCE_TYPE_CODE = 'INVALID_ABSENCE_TYPE'.freeze
    INVALID_TEAM_CODE = 'INVALID_TEAM_CODE'.freeze
    INVALID_POSITION_CODE = 'INVALID_POSITION'.freeze
    INVALID_CONTRACT_TYPE_CODE = 'INVALID_CONTRACT_TYPE'.freeze
    INVALID_CREATE_DATE_FROM_CODE = 'INVALID_CREATE_DATE_FROM'.freeze
    INVALID_CREATE_DATE_TO_CODE = 'INVALID_CREATE_DATE_TO'.freeze
    INVALID_CREATE_UPDATE_FROM_CODE = 'INVALID_CREATE_UPDATE_FROM'.freeze
    INVALID_CREATE_UPDATE_TO_CODE = 'INVALID_CREATE_UPDATE_TO'.freeze
    INVALID_FORM_DATA_CODES = [
      INVALID_EMPLOYEE_CODE,
      INVALID_DATE_FROM_CODE,
      INVALID_DATE_TO_CODE,
      INVALID_ABSENCE_TYPE_CODE,
      INVALID_TEAM_CODE,
      INVALID_POSITION_CODE,
      INVALID_CONTRACT_TYPE_CODE,
      INVALID_CREATE_DATE_FROM_CODE,
      INVALID_CREATE_DATE_TO_CODE,
      INVALID_CREATE_UPDATE_FROM_CODE,
      INVALID_CREATE_UPDATE_TO_CODE
    ].freeze

    def absence_requests_find(options = {})
      response = self.class.post(
        FIND_ENDPOINT_PATH,
        body: options.to_json
      )
      if response.ok?
        Entries.build(
            response.parsed_response
        )
      else
        handle_errors(response.parsed_response['code'])
      end
    end

    def absence_requests_find_advanced(options = {})
      response = self.class.post(
        FIND_ADVANCED_ENDPOINT_PATH,
        body: options.to_json
      )
      if response.ok?
        Entries.build_advanced(
          response.parsed_response
        )
      else
        handle_errors(response.parsed_response['code'])
      end
    end

    private

    def handle_errors(code)
      raise UnknownErrorCodeError unless INVALID_FORM_DATA_CODES.include?(code)

      raise InvalidFormData, "Invalid form data! Code: #{code}"
    end
  end
end