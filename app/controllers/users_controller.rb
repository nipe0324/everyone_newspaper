class UsersController < ApplicationController
  # ログインしてるユーザだけ、show, edit, updateにアクセスできる
  before_action :logined_user, only: [:index, :show, :edit, :update]
  # 正しいユーザだけ、show, edit, updateにアクセスできる
  before_action :correct_user, only: [:show, :edit, :update]
  # 管理者だけ、indexを実行できる
  before_action :admin_user, only: :index
  # 正しいユーザ、もしくは、管理者だけ、destroyできる
  before_action :correct_or_admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

	def show
		@user = User.find(params[:id])
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


    # For Before Actions
    def logined_user
      unless login?
        store_location
        redirect_to login_url, notice: "ログインをして下さい。"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def correct_or_admin_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user) || current_user.admin?
    end
end
