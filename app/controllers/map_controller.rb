class MapController < ApplicationController

	CALLBACK_URL = "http://localhost:3000/map/callback"

	#ask for user to login to instagram upon navigating to this page
	def index
		redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)	
	end     

	def callback
	  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
	  session[:access_token] = response.access_token
	  redirect_to "http://localhost:3000/map"
	end

	def show

	end

	# protected

	# def authenticate
	# 	authenticate_or_request_with_http_basic do |username, password|
	# 		client_id == APP_CONFIG['client_id'] && client_secret == APP_CONFIG['client_secret']
	# 	end
	# end

end
