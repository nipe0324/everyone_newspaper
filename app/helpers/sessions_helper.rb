module SessionsHelper

	def login user
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def login?
		!current_user.nil?
	end

	def logout
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	# フレンドリーフォワーディング
	def redirect_back_or default
		redirect_to session[:return_to] || default
		session.delete :return_to
	end

	def store_location
		session[:return_to] = request.url
	end

	# ログインしているか
  def logined_user
    unless login?
      store_location
      redirect_to login_url, notice: "ログインをして下さい。"
    end
  end

  # 正しいユーザか
  def correct_user
  	if params[:user_id]
	  	@user = User.find(params[:user_id])
	  elsif params[:id]
	  	@user = User.find(params[:id])	if params[:id]
	  end
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def correct_or_admin_user
  	@user = User.find(params[:id])	if params[:id]
  	@user = User.find(params[:user_id])	if params[:user_id]    
    redirect_to root_path unless current_user?(@user) || current_user.admin?
  end
end
