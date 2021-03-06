class ArticlesController < ApplicationController
  # ログインしてるユーザだけがアクセスできる
  before_action :logined_user, except: :index
  # 正しくないユーザはアクセスできない
  before_action :correct_user, except: [:index, :vote]

  def index
    @categories = Category.all
    @view_mode = params[:view] # ""の場合 Grid, "list"の場合 List
  end

  def new
  	@article = @user.articles.build
  end

  def create
  	@article = @user.articles.build(article_params)
  	if @article.save
  		flash[:success] = "記事を投稿しました。"
  		redirect_to current_user
  	else
  		render 'new'
  	end
  end

  def edit
  	@article = Article.find(params[:id])
  end

  def update
  	@article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "記事を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "記事を削除しました。"
    redirect_to @user
  end

  def vote
    vote = current_user.article_votes.build(value: params[:value], article_id: params[:id])
    if vote.save
      flash[:success] = "投票ありがとうございます。"
    else
      flash[:error] = "既に投票済みです。"
    end
    redirect_to :back
  end

  private

  	def article_params
  		params.require(:article).permit(:title, :content, :category_id, :picture)
  	end
end