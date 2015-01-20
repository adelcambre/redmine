module Redmine
  class Base < ActiveResource::Base
    self.site = Redmine.configuration.site

    cattr_accessor :static_headers
    self.static_headers = headers

    DEFAULTS = {}

    def initialize(attributes = {}, persisted = false)
      attributes.merge!(self.class::DEFAULTS)
      attributes.merge!(Redmine.configuration.resources[self.class.element_name.to_sym] || {})
      
      super(attributes, persisted)
    end

    def self.headers
      new_headers = static_headers.clone
      new_headers["X-Redmine-API-Key"] = Redmine.configuration.api_key

      new_headers
    end
  end
end