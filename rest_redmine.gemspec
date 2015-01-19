require File.expand_path('../lib/rest_redmine/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rest_redmine'
  s.version     = RestRedmine::VERSION
  s.licenses    = ['MIT']
  s.summary     = "This is for restful api of redmine"
  s.description = 'A simple HTTP and REST client for REDMINE.'
  s.authors     = ["topray"]
  s.email       = 'topray@nowbusking.com'
  s.files       = `git ls-files -z`.split("\0")
  s.homepage    = 'https://github.com/topray/rest-redmine'

  s.add_dependency('rest-client', '~> 1.7', '>= 1.7.2')
end