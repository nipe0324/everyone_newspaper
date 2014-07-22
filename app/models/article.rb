class Article < ActiveRecord::Base

	# 写真を追加
	has_attached_file :picture,
		:styles => { thumb: "130x130>" }, # 画像サイズを指定
		:url  => "/assets/articles/:id/:style/:basename.:extension", # 画像保存先のURL先
		:path => "#{Rails.root}/public/assets/articles/:id/:style/:basename.:extension" # サーバ上の画像保存先パス

	# 関連
	belongs_to :user
	belongs_to :category

	# 検証
	validates :title, presence: true, length: { maximum: 40 }
	validates :content, presence: true, length: { maximum: 1000 }
	validates :user_id, presence: true
	validates :category_id, presence: true
  validates_attachment :picture, less_than: 1.megabytes, # ファイルサイズのチェック
      content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] } # ファイルの拡張しチェック

	# スコープ
	default_scope -> { order('created_at DESC') }
end
