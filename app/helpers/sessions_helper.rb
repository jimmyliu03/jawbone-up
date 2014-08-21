module SessionsHelper

	def current_user
  	User.find(session[:user_id]) if session[:user_id]
	end

	def auth
		token = current_user.authorizations.first.token
  		auth = "Bearer " + token
  	end

end



