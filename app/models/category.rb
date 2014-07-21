class Category < ActiveRecord::Base

	# 関連
	has_many :articles

	# 検証
	validates :name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
end
