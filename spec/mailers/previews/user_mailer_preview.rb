# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.create_reset_digest
    UserMailer.password_reset(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/invitation
  def invitation
    user = User.first
    group = Group.first
    UserMailer.invitation(user, group)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/acception
  def acception
    group_user = User.first
    accept_user = User.second
    group = Group.first
    UserMailer.acception(group_user, accept_user, group)
  end
end
