class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @relationship = current_group.relationships.build(user_id: @user.id, status: 'invite')
    @relationship.save
    flash[:success] = "ユーザーを招待しました"
    redirect_to current_group
  end
end
