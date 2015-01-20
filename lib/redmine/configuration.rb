module Redmine
  class Configuration
    attr_accessor :api_key, :site, :resources

    def initialize
      @resources = {}
    end
  end
end