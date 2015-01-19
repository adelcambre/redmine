module RestRedmine
  module Resources
    class Issue < Base
      KEYS = [
        :project_id, :tracker_id, :status_id, :priority_id, :subject, :description, :category_id, :parent_issue_id, :custom_fields, :watcher_user_ids, :is_private, :estimated_hours, :done_ratio
      ]

      DEFAULT_MODEL = {
        custom_fields: {},
        is_private: false,
        done_ratio: 0
      }

      RESOURCE = "issues"

      def statuses
        RestRedmine::API.request("issue_statuses")
      end
    end
  end
end