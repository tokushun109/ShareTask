module SessionsHelper
    def current_user
        # @current_userに既に値が入っている場合、そのまま
        # 値が入っていない場合、@current_userにsession[:user_id]のuserを代入する
        # →ログイン時にsessions[:user_id]にはログインしたuser.idが代入されている
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !!current_user
    end
    
end
