module RestRedmine
  class Configuration
    attr_accessor :api_key, :server_url, :timeout, :resources, :retries

    def initialize
      @resources = {}
      @retries = 1
    end
  end
end