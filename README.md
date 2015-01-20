# Redmine

## Install

In terminal

```
gem install redmine

```

If you wish to bundle, you must add the following line to your Gemfile.

```
gem 'redmine'

```

## Quick start
```
Redmine.configure do |config|
  config.api_key = <:api_key>
  config.site = <:site>

  # if you need, you can define default values.
  config.resources[:issue] = {
    project_id: 1,
    tracker_id: 1,
    ...
  }
end

issue = Redmine::Issue.find(1)
issue.project_id = 4
issue.save

Redmine::TimeEntry.create(
  issue_id: 1,
  hours: 4.3,
  comments: "Hello world!"
)

```

## Git hook

[Here](https://gist.github.com/topray/526dd9d131bb6f3e3281) is commit-msg gist for git hook.