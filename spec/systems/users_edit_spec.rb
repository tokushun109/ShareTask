require 'rails_helper'

RSpec.describe 'users_edit', type: :system do

  let(:user) { create(:user) }

  scenario '無効な登録情報の時、編集できない' do
    log_in_as(user, "foobar")
    get edit_user_path(user)
    expect(response.body). to include 'ユーザー情報編集'
    patch user_path(user), params: { user: { name:  "",
                                             user_name: "",
                                             email: "foo@invalid" }}
    expect(response.body). to include 'ユーザー情報編集'
  end

  scenario '有効な登録情報の時、編集できる' do
    log_in_as(user, "foobar")
    get edit_user_path(user)
    expect(response.body). to include 'ユーザー情報編集'
    patch user_path(user), params: { user: { name:  "edit_name",
                                             user_name: "edit_user_name",
                                             email: "edit_user@example.com" }}
    expect(flash.empty?). to be_falsey
    expect(response).to redirect_to groups_path
    follow_redirect!
    expect(response.body). to include 'グループ一覧'
    user.reload
    expect("edit_name").to eq user.name
    expect("edit_user_name").to eq user.user_name
    expect("edit_user@example.com").to eq user.email
  end
end
