module Redmine
  class Configuration
    attr_accessor :api_key, :server_url, :resources

    def initialize
      @resources = {}
    end
  end
end