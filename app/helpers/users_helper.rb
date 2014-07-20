module UsersHelper

	# 与えられたユーザーのアバター画像を返す
	def avatar_for(user, options = { size: 80 })
		size = options[:size]
		image_tag("no_avatar.png", alt: user.name, class: "img-rounded", size: "#{size}x#{size}" )
	end

end