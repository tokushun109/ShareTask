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
    unless current_user == user
      redirect_to groups_url
    else
      @group = Group.find_by(id: params[:group_id])
    end
  end

  def accept
    group = Group.find_by(id: params[:group_id])
    @relationship = group.relationships.find_by(user_id: current_user.id)
    @relationship.status = 'accept'
    @relationship.save
    # groupのusersを取得して、それぞれにメールを送ればいい
    # groupにcurrent_userが追加されたという内容を送りたい
    # send_acception_email(current_user, current_group)のメソッドをuserモデルに追加する必要あり
    group.users.each(&:send_acception_email(current_user, current_group))
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
