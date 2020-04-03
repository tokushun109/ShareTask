module SystemsHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, password)
    get login_url
    post login_path, params: { session: { user_name: user.user_name,
                                          password: password } }
  end
end
