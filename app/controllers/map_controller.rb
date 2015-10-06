class MapController < ApplicationController

	CALLBACK_URL = "http://localhost:3000/map/callback"
	# 2. CALLBACK - routes here after user give oauth info
	
	def landing
		redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
			# 1. ask for user to login to instagram upon navigating to this page
			#***MAYBE ADD TO INDEX***
	end

	def callback
	  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
	  session[:access_token] = response.access_token
	  redirect_to map_index_path
	  # 3. gets access token and redirects to map/index
	end

	def index
		client = Instagram.client(access_token: session[:access_token])
		@user = client.user
		@first_visit

		if !User.where(username: @user.username).first
			new_user = User.create(
				username: @user.username,
				profile_pic: @user.profile_picture,
				pic_count: @user.counts.media,
				)
			@first_visit = true;
		else
			@first_visit = false;
			user = User.where(username: @user.username).first
				user.profile_pic = @user.profile_picture
				user.pic_count = @user.counts.media
				user.save
			end
			erb :index #index show page
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
