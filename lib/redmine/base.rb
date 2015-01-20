module Redmine
  class Base < ActiveResource::Base
    cattr_accessor :static_headers
    self.static_headers = headers

    DEFAULTS = {}

    def initialize(attributes = {}, persisted = false)
      attrs = {}
      attrs.merge!(self.class::DEFAULTS)
      attrs.merge!(Redmine.configuration.resources[self.class.element_name.to_sym] || {})
      attrs.merge!(attributes)

      super(attrs, persisted)
    end

    def self.headers
      new_headers = static_headers.clone
      new_headers["X-Redmine-API-Key"] = Redmine.configuration.api_key

      new_headers
    end

    def encode(options={})
      send("to_#{self.class.format.extension}", options)
    end
  end
end