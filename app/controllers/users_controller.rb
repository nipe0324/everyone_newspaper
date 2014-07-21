class UsersController < ApplicationController
  # ログインしてるユーザだけ、show, edit, updateにアクセスできる
  before_action :logined_user, only: [:index, :show, :edit, :update]
  # 正しいユーザだけ、edit, updateにアクセスできる
  before_action :correct_user, only: [:edit, :update]
  # 管理者だけ、indexを実行できる
  before_action :admin_user, only: :index
  # 正しいユーザ、もしくは、管理者だけ、showとdestroyできる
  before_action :correct_or_admin_user, only: [:show, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

	def show
		@user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      login @user
  		flash[:success] = "ようこそ「みんなの新聞」へ。ユーザアカウントを登録しました。"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end


  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    if current_user.admin?
      flash[:success] = "ユーザを削除しました。"
      redirect_to users_url
    else
      flash[:success] = "ご利用ありがとうございました。"
      redirect_to root_url
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
