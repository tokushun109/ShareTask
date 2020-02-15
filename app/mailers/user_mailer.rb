class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定用のリンクを送信いたします。"
  end

<<<<<<< HEAD
  def invitation(user, group)
    @group = group
=======
  def invitation(user)
    @user = user
>>>>>>> fce5f5946249e7bbeb371ad61511217ba659b651
    mail to: user.email, subject: "グループに招待されています。"
  end

end
