module RestRedmine
  class Configuration
    attr_accessor :api_key, :server_url, :timeout

    def initialize(api_key, server_url, timeout = 5)
      @api_key = api_key
      @server_url = server_url
      @timeout = timeout
    end
  end
end