require 'minitest/autorun'
require 'redmine'
require 'yaml'

class RedmineTest < Minitest::Test
  def setup
    configuration = YAML.load_file('test/config.yml')

    @api_key = configuration["api_key"]
    @site = configuration["site"]

    Redmine.configure do |config|
      config.api_key = @api_key
      config.server_url = @server_url
      config.resources[:issue] = {
        project_id: 1, # nowplay
        tracker_id: 1, # bug
        status_id: 1, # new
        priority_id: 2, # normal
        category_id: 1
      }
    end

    @issue = Redmine::Issue.new
  end

  def test_configuration
    assert_equal @api_key, Redmine.configuration.api_key
  end
end
