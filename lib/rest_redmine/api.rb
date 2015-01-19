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

    def self.request(action, data: {}, id: nil, method: :get)
      retries ||= RestRedmine.configuration.retries
      url = get_path(action, id: id)

      if RestRedmine.configuration.api_key.nil?
        message = "
You must set configure first.

RestRedmine.configure do |config|
  config.api_key = '<api_key>'
  config.server_url = '<server_url>'
end
        "
        raise RestRedmine::Exception.new(message)
      end

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
    rescue RestRedmine::Exception => e
      RestRedmine.log << e
      RestRedmine.log << "REDMINE FAIL\nurl - #{url}\nparams - #{data}\nmethod - #{method}"
    rescue => e
      RestRedmine.log << e
      RestRedmine.log << "REDMINE FAIL\nurl - #{url}\nparams - #{data}\nmethod - #{method}"
      retry unless (retries -= 1).zero?
    else
      if response.length > 0
        JSON.parse(response)
      else
        true
      end
    end
  end
end