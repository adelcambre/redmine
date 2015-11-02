module Redmine
  class Project < Base
    def add_member(user)
      user_id = if user.is_a?(Redmine::User)
                  user.id
                else
                  user
                end

      post(:memberships, :membership => {:user_id => user_id, :role_ids => [3]})
    end
  end
end

