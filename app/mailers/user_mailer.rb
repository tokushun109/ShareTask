class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【ShareTask】パスワードの再設定用のリンクを送信いたします。"
  end

  def invitation(user, group)
    @user = user
    @group = group
    mail to: user.email, subject: "【ShareTask】#{@group}グループに招待されています。"
  end

  def acception(group_user, accept_user, group)
    @accept_user = accept_user
    @group = group
    mail to: group_user.email, subject: "【ShareTask】#{@accept_user.name}さんが#{@group.name}グループに参加しました。"
  end


end
