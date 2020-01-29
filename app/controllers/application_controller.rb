# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include GroupsHelper
  include TasksHelper
  before_action :set_invite_groups, if: :logged_in?

  private
  def set_invite_groups
    @invite_relationships = current_user.relationships.where(status: 'invite')
<<<<<<< HEAD
    @invite_groups = @invite_relationships.map { |invite_relationship| Group.find_by(id: invite_relationship.group_id) }
=======
    @invite_groups = @invite_relationships.map { |invite_relationship|Group.find_by(id: invite_relationship.group_id) }
>>>>>>> 23459f00005a6af65a102aa7544efef3fb1a2df6
  end

  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end
end
