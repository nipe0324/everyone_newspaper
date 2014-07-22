class Article < ActiveRecord::Base

	# 写真を追加
	has_attached_file :picture,
		:styles => { thumb: "130x130>" }, # 画像サイズを指定
		:url  => "/assets/articles/:id/:style/:basename.:extension", # 画像保存先のURL先
		:path => "#{Rails.root}/public/assets/articles/:id/:style/:basename.:extension" # サーバ上の画像保存先パス

	# 関連
	belongs_to :user
	belongs_to :category
	has_many :article_votes

	# 検証
	validates :title, presence: true, length: { maximum: 40 }
	validates :content, presence: true, length: { maximum: 5000 }
	validates :user_id, presence: true
	validates :category_id, presence: true
  validates_attachment :picture, less_than: 1.megabytes, # ファイルサイズのチェック
      content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] } # ファイルの拡張しチェック

	# スコープ
	default_scope -> { order('created_at DESC') }

	def self.by_votes
		select('article.*, coalesce(value, 0) as votes').
    joins('left join article_votes on article_id=articles.id').
    order('votes desc')
	end

	def votes
		read_attribute(:votes) || article_votes.sum(:value)
	end
end
