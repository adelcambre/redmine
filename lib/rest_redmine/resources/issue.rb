module RestRedmine
  module Resources
    class Issue < Base
      KEYS = [
        :project_id, :tracker_id, :status_id, :priority_id, :subject, :description, :category_id, :parent_issue_id, :custom_fields, :watcher_user_ids, :is_private, :estimated_hours, :done_ratio
      ]

      def initialize()
        super(KEYS)
      end

      def issue_statuses
        request("issue_statuses", method: :get)
      end

      def update_issue(id, status_id: nil, done_ratio: nil, notes: nil)
        data = {
          issue: {
            status_id: status_id,
            notes: notes
          }
        }
        data[:issue][:done_ratio] = done_ratio if done_ratio

        request("issues", id: id, data: data, method: :put)
      end

      def new_issue(subject: nil, description: nil)
        data = {
          issue: {
            project_id: 1, # nowplay
            tracker_id: 1, # bug
            status_id: 1, # new
            priority_id: 2, # normal
            subject: subject,
            description: description,
            category_id: 1, 
            parent_issue_id: nil,
            custom_fields: {},
            watcher_user_ids: nil,
            is_private: false,
            estimated_hours: nil,
            done_ratio: 0
          }
        }

        request("issues", data: data)
      end

      def method_missing(method, *args, &block)  
        if method.include? method
          data[method.to_sym]
        else
          super
        end
      end  
    end
  end
end