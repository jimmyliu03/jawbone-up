class DataProcessorController < ApplicationController
  def today
  	if session[:token]
	  	@token = session[:token]
	  	client = Jawbone::Client.new @token
	  	@goals_raw = client.goals
		@moves_raw = client.moves
		@sleep_raw = client.sleeps
		@current_user = client.user["data"]["first"] + " " + client.user["data"]["last"] unless @current_user
		@current_steps = client.moves["data"]["items"].first["title"]
		@goal_steps = @goals_raw["data"]["move_steps"]
		@goal_steps_remaining = @goals_raw["data"]["remaining_for_day"]["move_steps_remaining"]
		@current_sleep = client.sleeps["data"]["items"].first["title"]
	  	@authorization = "Bearer " + @token
		#@auth = "Bearer " + session[:current_user].authorizations.first.token unless session[:user_id].nil?
		#@result = HTTParty.get('http://jawbone.com/nudge/api/v.1.1/users/@me/moves',
	                           #:headers => { "Authorization" => @authorization, "Accept" => "application/json"}) unless session[:token].nil?
		
	else
		redirect_to '/auth/jawbone'
	end
  end
end
