class SessionsController < ApplicationController



  def new
  end

  def create

	if session[:user_id] && session[:token]
		#if there's a session, then create the authorization
		#User.find(session[:user_id]).authorizations.find_or_create(auth_hash)
		#render :text => "Session exists with user id #{session[:user_id]} and session token #{session[:token]}"


	else 
		auth_hash = request.env['omniauth.auth']
		auth = Authorization.find_or_create(auth_hash)
		session[:user_id] = auth.user.id
		session[:token] = auth_hash["credentials"]["token"]
		#render :text => "Session did not exist. Session created with #{session[:user_id]} and session token #{session[:token]} and real token #{auth_hash["credentials"]["token"]}"

	#@authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	#@current_user = User.find_by(uid: auth_hash["uid"]) #unless @current_user.nil?

	# @current_user = User.create(uid: auth_hash["uid"], name:auth_hash["uid"], email:auth_hash["uid"], password:auth_hash["uid"], password_confirm: auth_hash["uid"]) if @current_user.nil?
	# @authorization = Authorization.create(:provider => auth_hash["uid"], :uid => auth_hash["uid"], :token => auth_hash["credentials"]["token"], :user_id => @current_user.id) if @authorization.nil?

	# session[:user_id] = @current_user.id
	# session[:auth] = "Bearer " + @current_user.authorizations.first.token

    #render :text => "Before if statements #{@current_user.token}"
	end
	#render :text => "Auth inspect #{current_user.authorizations.inspect}"
    redirect_to '/today'
  end

  def failure
  end

  def destroy


  #@current_user.authorization.destroy unless @current_user.nil?
  #@current_user.destroy unless @current_user.nil?
  # session[:user_id] = nil
  # session[:token] = nil
  reset_session
  render :text => "You've logged out!"
  end

end
