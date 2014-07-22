class ArticleVote < ActiveRecord::Base
	# 関連
  belongs_to :article
  belongs_to :user

  # 検証
  validates :article_id, uniqueness: { scope: :user_id }
  validates :value, inclusion: { in: [1, -1] }
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the article" if article.user_id == user_id
  end
end
