# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_group, only: %i[show edit update destroy]

  def index
    @relationships = current_user.relationships.where(status: 'accept')
    @accept_groups = []
    @relationships.each do |relationship|
      @accept_groups.push(Group.find(relationship.group_id))
    end
    @accept_groups = Kaminari.paginate_array(@accept_groups).page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def create
    # group_paramsをストロングパラメータで定義する必要あり
    @group = current_user.leader_groups.build(group_params)
    # @group = Group.new(group_params)

    if @group.save
      @relation = current_user.relationships.create(group_id: @group.id, status: 'accept')
      flash[:success] = '新しいグループを作成しました'
      # 後ほどgroups_urlに飛ばせるようにする
      redirect_to @group

    else
      flash.now[:danger] = 'グループを作成出来ませんでした'
      render :new
    end
  end

  def show
    session[:group_id] = params[:id]
    @relationships = current_group.relationships.where(status: 'accept')
    @accept_users_name = []
    @relationships.each do |relationship|
      @accept_users_name.push(User.find(relationship.user_id).name)
      @tasks = current_group.tasks.order(status: :desc).order(time_limit: :asc).page(params[:page]).per(10)
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'グループ名を変更しました'
      redirect_to @group
    else
      flash.now[:danger] = 'グループ名を変更できませんでした'
      render :edit
    end
  end

  def destroy
    @group.destroy
    session[:group_id] = nil
    flash[:success] = 'グループを削除しました'
    redirect_to groups_url
  end
end
private

def group_params
  params.require(:group).permit(:name)
end

def correct_group
  @group = current_user.groups.find_by(id: params[:id])
  redirect_to groups_url unless @group
end
