class ApplicationController < ActionController::Base
    include SessionsHelper
    include GroupsHelper
     before_action :set_invite_groups, if: :logged_in?
    
    def set_invite_groups
        @invite_relationships = current_user.relationships.where(status: 'invite')
        @invite_groups = []
        @invite_relationships.each do |invite_relationship|
        @invite_groups.push(Group.find_by(id: invite_relationship.group_id))
        end
    end
end