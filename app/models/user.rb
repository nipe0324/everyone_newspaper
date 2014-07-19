class User < ActiveRecord::Base
	VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	# email属性を小文字に変換してメールアドレスの一意性を保証
	before_save { self.email = email.downcase }


	# パスワード用のカラム
	has_secure_password

	# 検証
	validates :name,		presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

end

