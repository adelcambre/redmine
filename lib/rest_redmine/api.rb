require 'rest_redmine/resources'
require 'json'

module RestRedmine
  module API
    class << self
      attr_accessor :config
    end

    def self.get_path(action, id: nil)
      url = "#{RestRedmine.configuration.server_url}/#{action}"
      url += "/#{id}" if id
      url += ".json"

      url
    end

    def self.request(action, data: {}, id: nil, method: :post)
      retries ||= 3
      url = get_path(action, id: id)

      response = RestClient::Request.execute(
        :method => method, 
        :url => url, 
        :payload => data, 
        :headers => {
          :accept => :json,
          "X-Redmine-API-Key" => RestRedmine.configuration.api_key
        },
        :timeout => RestRedmine.configuration.timeout,
        :open_timeout => RestRedmine.configuration.timeout
      )
    rescue => e
      RestRedmine.log << e
      RestRedmine.log << "REDMINE FAIL\nurl - #{url}\nparams - #{data}"
      retry unless (retries -= 1).zero?
    else
      RestRedmine.log << "REDMINE SUCCESS\nurl - #{url}\nparams - #{data}\nresult - #{response}"

      JSON.parse(response)
    end
  end
end