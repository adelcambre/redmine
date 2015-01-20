require 'active_resource'
require 'logger'

require 'redmine/version'
require 'redmine/exception'
require 'redmine/configuration'
require 'redmine/base'
require 'redmine/issue'
require 'redmine/time_entry'

module Redmine
  class << self
    attr_writer :configuration, :log
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)

    Redmine::Base.site = configuration.site
  end

  def self.create_logger
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN
  end

  def self.logger
    @logger
  end

  Redmine.create_logger
  ActiveResource::Base.include_root_in_json = true
end