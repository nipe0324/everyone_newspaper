class User < ActiveRecord::Base
	VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	# 生成時に、トークンを作成
	before_create :create_remember_token
	# 保存前時に、email属性を小文字に変換してメールアドレスの一意性を保証
	before_save { self.email = email.downcase }

	# パスワード用のカラム
	has_secure_password

	# 写真を追加
	has_attached_file :avatar,
		:styles => { thumb: "130x130>" }, # 画像サイズを指定
		:url  => "/assets/users/:id/:style/:basename.:extension", # 画像保存先のURL先
		:path => "#{Rails.root}/public/assets/users/:id/:style/:basename.:extension" # サーバ上の画像保存先パス

	# 関連
	has_many :articles, dependent: :destroy

	# 検証
	validates :name,		presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
  validates_attachment :avatar, less_than: 1.megabytes, # ファイルサイズのチェック
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] } # ファイルの拡張しチェック


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  	# トークンを作成する
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end