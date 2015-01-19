module RestRedmine
  class API
    attr_accessor :config

    def initialize(config = Configuration.new)
      @config = config
    end

    def get_path(action, id: nil)
      url = "#{@config.server_url}/#{action}"
      url += "/#{id}" if id
      url += ".json"

      url
    end

    def send(action, data: {}, id: nil, method: :post)
      retries ||= 3
      
      response = RestClient::Request.execute(
        :method => method, 
        :url => get_path(action, id: id), 
        :payload => data, 
        :headers => {
          :accept => :json,
          "X-Redmine-API-Key" => api_key
        },
        :timeout => TIMEOUT,
        :open_timeout => TIMEOUT
      )
    rescue => e
      RestRedmine.log e
      RestRedmine.log "REDMINE FAIL: #{action}, #{data}"
      retry unless (retries -= 1).zero?
    else
      RestRedmine.log "REDMINE SUCCESS: #{action}, #{data}"

      response
    end
  end
end