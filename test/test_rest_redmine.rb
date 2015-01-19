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
      config.resources[:issue] = {
        project_id: 1, # nowplay
        tracker_id: 1, # bug
        status_id: 1, # new
        priority_id: 2, # normal
        category_id: 1
      }
    end

    @issue = RestRedmine::Resources::Issue.new
  end

  def test_configuration
    assert_equal @api_key, RestRedmine.configuration.api_key
  end

  def test_resources    
    assert_equal true, @issue.model.keys.length > 0
  end

  def test_issue_statuses
    assert_equal Hash, @issue.statuses.class
  end

  def test_exception
    message = "You must set configure"
    e = RestRedmine::Exception.new(message)
    assert_equal message, e.message
  end

  def test_default_resource
    assert_equal 1, @issue.status_id
  end

  def test_get_issue
    @issue.id = 37
    response = @issue.load
    assert_equal 5, response["issue"]["status"]["id"]
  end

  def test_create_issue
    # @issue.load
    @issue.subject = "테스트테스트"
    @issue.description = "설명"
    @issue.status_id = 2
    response = @issue.save

    assert_equal true, response["issue"].any?

    @issue.status_id = 5
    response = @issue.save

    assert_equal true, response
  end
end
