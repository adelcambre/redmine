module Redmine
  class Issue < Base
    schema do
      integer 'project_id', 'tracker_id', 'status_id', 'priority_id', 'category_id', 'parent_issue_id', 'estimated_hours', 'done_ratio'
      boolean 'is_private'
    end

    DEFAULTS = {
      custom_fields: {},
      is_private: false,
      done_ratio: 0
    }
  end
end