class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# ユーザをログインさせ、ユーザーページにリダイレクト
			login user
			redirect_back_or user
		else
			# エラーメッセージを表示し、ログインページをRendre
			flash.now[:error] = "ユーザID・パスワードに誤りがあるか、登録されていません。"
			render 'new'
		end
	end

	def destroy
		logout
		redirect_to root_url
	end
end
