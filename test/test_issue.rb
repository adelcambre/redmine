require 'minitest/autorun'
require 'redmine'
require 'yaml'

class IssueTest < Minitest::Test
  def setup
    configuration = YAML.load_file('test/config.yml')

    @api_key = configuration["api_key"]
    @site = configuration["site"]

    Redmine.configure do |config|
      config.api_key = @api_key
      config.site = @site
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

  def test_init_issue
    assert_equal nil, @issue.id
  end

  def test_find_empty_issue
    assert_raises ActiveResource::ResourceNotFound do
      issue = Redmine::Issue.find(1)
    end
  end

  # def test_find_issue
  #   issue = Redmine::Issue.find(48)
  # end

  # def test_save_issue
  #   issue = Redmine::Issue.new({
  #     subject: "안녕안녕",
  #     status_id: 5

  #   })

  #   assert_equal true, issue.save
  #   assert_equal 5, issue.status_id
  # end
end
