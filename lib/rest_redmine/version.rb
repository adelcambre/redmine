module RestRedmine
  VERSION = '0.1.2' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end