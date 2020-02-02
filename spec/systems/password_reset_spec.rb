require 'rails_helper'

RSpec.describe 'password_reset', type: :system do

  before do
    ActionMailer::Base.deliveries.clear
    get new_password_reset_url
  end
  let(:user) { create(:user) }

  context 'メールアドレスが無効な時' do
    it '"登録したメールアドレスと異なるため、メールを送信できませんでした"のフラッシュが入っていること' do
      expect(response.body).to include 'パスワードをお忘れですか？'
      post password_resets_url, params: { password_reset: { email: "" } }
      expect(response.body).to include '登録したメールアドレスと異なるため、メールを送信できませんでした'
      expect(response.body).to include 'パスワードをお忘れですか？'
    end
  end

  context 'メールアドレスが有効な時' do
    it 'reset_digest生成して、メールを送信後root_urlにリダイレクトすること' do
      expect(response.body).to include 'パスワードをお忘れですか？'
      before_reset_digest = user.reset_digest
      post password_resets_url, params: { password_reset: { email: user.email } }
      after_reset_digest = user.reload.reset_digest
      expect(after_reset_digest).not_to eq before_reset_digest
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(response).to redirect_to root_path
      follow_redirect!
      expect(response.body).to include '登録して使ってみる'
      expect(response.body).to include 'パスワード再設定用のメールを送信しました'
      # get edit_password_reset_path(after_reset_digest, email: "")
      # expect(response).to redirect_to root_path
    end
  end
end
