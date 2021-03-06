# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    user = User.find(params[:user_id])
    @relationship = current_group.relationships.build(user_id: user.id, status: 'invite')
    @relationship.save
    user.send_invitation_email(current_group)
    flash[:success] = '招待メールを送信しました'
    redirect_to current_group
  end

  def invite
    user = User.find_by(id: params[:user_id])
    if current_user == user
      @group = Group.find_by(id: params[:group_id])
    else
      redirect_to groups_url
    end
  end

  def accept
    group = Group.find_by(id: params[:group_id])
    @relationship = group.relationships.find_by(user_id: current_user.id)
    @relationship.status = 'accept'
    @relationship.save
    group.users.each do |user|
      user.send_acception_email(current_user, group)
    end
    flash[:success] = 'グループに参加しました'
    redirect_to groups_url
  end

  def deny
    group = Group.find_by(id: params[:group_id])
    @relationship = group.relationships.find_by(user_id: current_user.id)
    @relationship.destroy
    flash[:success] = '参加を辞退しました'
    redirect_to groups_url
  end
end
