class Client < ApplicationController
  		def goals
    	get_helper("users/@me/goals", {})
    end