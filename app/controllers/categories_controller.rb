class CategoriesController < ApplicationController
  # ログインしてるユーザだけがアクセスできる
  before_action :logined_user
  # 管理者のみアクセスできる
  before_action :admin_user

  def index
  	@categories = Category.all
  	@category = Category.new
  end

  def create
  	@category = Category.create(category_params)
  	if @category.save
  		flash[:success] = "カテゴリを追加しました。"
  	else
  		flash[:error] = @category.errors.full_messages.join
  	end
		redirect_to categories_url
  end

  def edit
  	@categories = Category.all
  	@category = Category.find(params[:id])
  	render 'index'
  end

  def update
  	@category = Category.find(params[:id])
  	if @category.update_attributes(category_params)
      flash[:success] = "カテゴリを更新しました。"
    else
			flash[:error] = @category.errors.full_messages.join
    end
 		redirect_to categories_url
	end

  def destroy
  	@category = Category.find(params[:id])
  	if @category.articles.count.zero?
	  	@category.destroy
	  	flash[:success] = "カテゴリを削除しました。"
	  else
	  	flash[:error] = "記事が存在するため、削除できません。"
	  end
		redirect_to categories_path
  end

  private

	def category_params
		params.require(:category).permit(:name)
	end

end