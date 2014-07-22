module UsersHelper

	# 与えられたユーザーのアバター画像を返す
	# アバター画像が登録されていないときはデフォルトの画像を返す
	def avatar_for(user, options = { size: 80 })
		image_url = user.avatar? ? user.avatar.url : "no_avatar.png"
		size = options[:size]
		image_tag(image_url, alt: user.name, class: "img-rounded", size: "#{size}x#{size}" )
	end

end