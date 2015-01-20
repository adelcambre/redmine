require File.expand_path('../lib/redmine/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'redmine'
  s.version     = Redmine::VERSION
  s.licenses    = ['MIT']
  s.summary     = "This is for resources of redmine"
  s.description = 'A simple REDMINE client, using Active Resource.'
  s.authors     = ["topray"]
  s.email       = 'topray@nowbusking.com'
  s.files       = `git ls-files -z`.split("\0")
  s.homepage    = 'https://github.com/topray/rest-redmine'

  s.add_dependency('activeresource', '~> 4.0.0', '>= 4.0.0')
end