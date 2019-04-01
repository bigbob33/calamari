require 'calamari/abscence_requests'
require 'calamari/current_shift_status'

module Calamari
  class Client
    include HTTParty
    include Calamari::AbsenceRequests
    include Calamari::CurrentShiftStatus
    format :json

    def initialize(domain: nil, api_key: nil, api_user: nil)
      @domain = domain || ENV['CALAMARI_DOMAIN']
      @api_key = api_key || ENV['CALAMARI_API_KEY']
      @api_user = api_user || ENV['CALAMARI_API_USER']

      auth = { username: @api_user, password: @api_key }

      self.class.default_options.merge!(
          base_uri: @domain + '/api',
          headers: { 'Accept' => 'application/json', 'Content-Type' =>'application/json' },
          basic_auth: auth,
      )
    end
  end
end

