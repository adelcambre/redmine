module Redmine
  VERSION = '0.1.3' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end