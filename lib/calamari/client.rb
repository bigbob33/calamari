require 'calamari/abscence_requests'

module Calamari
  class Client
    include HTTParty
    include Calamari::AbsenceRequests
    format :json

    def initialize(domain: nil, api_key: nil, api_user: nil)
      @domain = domain || ENV['CALAMARI_API_PATH']
      @api_key = api_key || ENV['CALAMARI_API_KEY']
      @api_user = api_user || ENV['API_USER']

      auth = { username: @api_user, password: @api_key }

      self.class.default_options.merge!(
          base_uri: @domain + '/api',
          headers: { 'Accept' => 'application/json', 'Content-Type' =>'application/json' },
          basic_auth: auth,
      )
    end
  end
end

