# frozen_string_literal: true

module GroupsHelper
  def current_group
    @current_group ||= Group.find_by(id: session[:group_id])
  end
end
