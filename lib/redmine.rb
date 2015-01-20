require 'active_resource'
require 'logger'

require 'redmine/version'
require 'redmine/exception'
require 'redmine/configuration'
require 'redmine/base'
require 'redmine/issue'

module Redmine
  class << self
    attr_writer :configuration, :log
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.create_logger
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN
  end

  def self.logger
    @logger
  end

  create_logger
end