require 'rails_helper'

RSpec.describe 'password_reset', type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end
  let(:user) { create(:user) }

  scenario 'パスワードの再設定' do
    # パスワード再設定メール送信画面
    get new_password_reset_url
    expect(response.body).to include 'パスワードをお忘れですか？'
    # 無効なメールアドレスを入力
    post password_resets_path, params: { password_reset: { email: '' } }
    expect(response.body).to have_selector 'div.alert'
    expect(response.body).to include 'パスワードをお忘れですか？'
    # 有効なメールアドレスを入力
    before_reset_digest = user.reset_digest
    post password_resets_path, params: { password_reset: { email: user.email } }
    after_reset_digest = user.reload.reset_digest
    get_user = assigns(:user)
    expect(after_reset_digest).not_to eq before_reset_digest
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(response).to redirect_to root_path
    follow_redirect!
    expect(response.body).to include '登録して使ってみる'
    expect(response.body).to have_selector 'div.alert'

    # パスワード再設定画面のリンク
    # emailが無効
    get edit_password_reset_url(get_user.reset_token, email: '')
    expect(response).to redirect_to root_path
    # reset_tokenが無効
    get edit_password_reset_url('wrong_token', email: user.email)
    expect(response).to redirect_to root_path
    # メールアドレスとreset_tokenが有効
    get edit_password_reset_url(get_user.reset_token, email: user.email)
    expect(response.body).to include 'パスワード再設定'

    # パスワード再設定画面のフォーム
    # 異なるパスワードを入れる
    patch password_reset_path(get_user.reset_token),
          params: { email: user.email,
                    user: { password: 'foobaz',
                            password_confirmation: 'barquux' } }
    expect(response.body).to have_selector 'div.alert'
    # 空のパスワードを入れる
    patch password_reset_path(get_user.reset_token),
          params: { email: user.email,
                    user: { password: '',
                            password_confirmation: '' } }
    expect(response.body).to have_selector 'div.alert'
    # 有効なパスワードを入れる
    patch password_reset_path(get_user.reset_token),
          params: { email: user.email,
                    user: { password: 'foobaz',
                            password_confirmation: 'foobaz' } }
    expect(is_logged_in?).to be_truthy
    expect(response).to redirect_to groups_path
    follow_redirect!
    expect(response.body).to have_selector 'div.alert'
  end

  scenario 'tokenの期限' do
    get new_password_reset_url
    post password_resets_path,
         params: { password_reset: { email: user.email } }
    get_user = assigns(:user)
    get_user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(get_user.reset_token),
          params: { email: get_user.email,
                    user: { password: 'foobar',
                            password_confirmation: 'foobar' } }
    expect(response).to redirect_to new_password_reset_url
    follow_redirect!
    expect(response.body).to have_selector 'div.alert'
  end
end
