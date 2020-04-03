require 'rails_helper'

RSpec.describe 'users_pw_edit', type: :system do
  let(:user) { create(:user) }

  scenario '無効な登録情報の時、編集できない' do
    log_in_as(user, 'foobar')
    get edit_pw_user_path(user)
    expect(response.body). to include 'ユーザー情報編集'
    patch user_path(user), params: { user: { password: 'foo',
                                             password_confirmation: 'bar' } }
    expect(response.body). to include 'ユーザー情報編集'
  end

  scenario '有効な登録情報の時、編集できる' do
    log_in_as(user, 'foobar')
    get edit_pw_user_path(user)
    expect(response.body). to include 'ユーザー情報編集'
    patch user_path(user), params: { user: { password: 'edit_password',
                                             password_confirmation: 'edit_password' } }
    expect(flash.empty?). to be_falsey
    expect(response).to redirect_to groups_path
    follow_redirect!
    expect(response.body). to include 'グループ一覧'
    user.reload
    expect(user.authenticate('edit_password')).to be_truthy
  end
end
