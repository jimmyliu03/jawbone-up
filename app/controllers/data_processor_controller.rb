class DataProcessorController < ApplicationController
  def today
  	if session[:token]
	  	@token = session[:token]
	  	client = Jawbone::Client.new @token
	  	@goals_raw = client.goals
		@moves_raw = client.moves
		@sleep_raw = client.sleeps
		@current_user = client.user["data"]["first"] + " " + client.user["data"]["last"] if @current_user.nil?
		@moves_snapshot_url = "http://jawbone.com" + @moves_raw["data"]["items"].first["snapshot_image"]
		@sleep_snapshot_url = "http://jawbone.com" + @sleep_raw["data"]["items"].first["snapshot_image"]
		@current_steps = client.moves["data"]["items"].first["title"]
		@goal_steps = @goals_raw["data"]["move_steps"].to_f
		@goal_steps_remaining = @goals_raw["data"]["remaining_for_day"]["move_steps_remaining"].to_f
		@goal_sleep = @goals_raw["data"]["sleep_total"].to_f
		@goal_sleep_remaining = @goals_raw["data"]["remaining_for_day"]["sleep_seconds_remaining"].to_f
		@current_sleep = client.sleeps["data"]["items"].first["title"]
	  	@authorization = "Bearer " + @token
		#@auth = "Bearer " + session[:current_user].authorizations.first.token unless session[:user_id].nil?
		#@result = HTTParty.get('http://jawbone.com/nudge/api/v.1.1/users/@me/moves',
	                           #:headers => { "Authorization" => @authorization, "Accept" => "application/json"}) unless session[:token].nil?
		@steps_percent = ((@goal_steps - @goal_steps_remaining)/@goal_steps*100).to_i.to_s + "%"
		@sleep_percent = ((@goal_sleep - @goal_sleep_remaining)/@goal_sleep*100).to_i.to_s + "%"
		#@sleep_percent = ((@goal_sleep - @goal_steps_remaining)/@goal_sleep*100).to_s + "%"

	else
		redirect_to '/auth/jawbone'
	end
  end
end
