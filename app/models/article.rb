class Article < ActiveRecord::Base

	# 関連
	belongs_to :user

	# 検証
	validates :title, presence: true, length: { maximum: 40 }
	validates :content, presence: true, length: { maximum: 1000 }
	validates :user_id, presence: true

	# スコープ
	default_scope -> { order('created_at DESC') }
end
