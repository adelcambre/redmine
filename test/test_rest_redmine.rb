require 'minitest/autorun'
require 'rest_redmine'
require 'yaml'

class RestRedmineTest < Minitest::Test
  def setup
    configuration = YAML.load_file('test/config.yml')

    @api_key = configuration["api_key"]
    @server_url = configuration["server_url"]

    RestRedmine.configure do |config|
      config.api_key = @api_key
      config.server_url = @server_url
    end

    @issue = RestRedmine::Resources::Issue.new
  end

  def test_configuration
    assert_equal @api_key, RestRedmine.configuration.api_key
  end

  def test_resources    
    assert_equal true, @issue.data.keys.length > 0
  end

  def test_issue_statuses
    assert_equal Hash, @issue.issue_statuses.class
  end

  def test_exception
    message = "You must set configure"
    e = RestRedmine::Exception.new(message)
    assert_equal message, e.message
  end
end
