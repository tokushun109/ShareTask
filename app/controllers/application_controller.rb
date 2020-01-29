# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include GroupsHelper
  include TasksHelper
  before_action :set_invite_groups, if: :logged_in?

  private
  def set_invite_groups
    @invite_relationships = current_user.relationships.where(status: 'invite')
    @invite_groups = @invite_relationships.map { |invite_relationship| Group.find_by(id: invite_relationship.group_id) }
  end

  def require_user_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください."
      redirect_to login_url
    end
  end
end
