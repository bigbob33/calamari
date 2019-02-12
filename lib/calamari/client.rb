module Calamari
  class Client
    def initialize(domain: nil, api_key: nil, api_user: nil)
      @domain = domain || ENV['CALAMARI_API_PATH']
      @api_key = api_key || ENV['CALAMARI_API_KEY']
      @api_user = api_user || ENV['API_USER']
    end

    def absence_request_find(employee:, from:, to:)
      endpoint_path = '/leave/request/v1/find'
      url = @domain + '/api' + endpoint_path
      auth = { username: @api_user, password: @api_key }
      data_json = { "employee" => employee, "from" => from, "to" => to }.to_json
      headers = { 'Accept' => 'application/json', 'Content-Type' =>'application/json' }

      response = HTTParty.post(url,
                               body: data_json,
                               headers: headers,
                               basic_auth: auth
                               )

      JSON.parse(response.body)
    end
  end
end

