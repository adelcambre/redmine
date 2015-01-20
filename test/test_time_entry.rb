require 'minitest/autorun'
require 'redmine'
require 'yaml'

class TimeEntryTest < Minitest::Test
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

      config.resources[:time_entry] = {
        activity_id: 9 # developer
      }
    end

    @te = Redmine::TimeEntry.new
  end

  def test_init
    te = Redmine::TimeEntry.create(
      issue_id: 55,
      hours: 4,
      comments: "하하하"
    )
  end
end
