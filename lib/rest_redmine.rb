require 'rest_redmine/configuration'
require 'rest_redmine/api'
require 'rest-client'

module RestRedmine
  class << self
    attr_writer :configuration, :log
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.create_log
    @log = RestClient.create_log("stdout")
  end

  def self.log
    @log
  end

  create_log
end