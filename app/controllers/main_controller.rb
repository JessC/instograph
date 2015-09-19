class MainController < ApplicationController
# before_action :authenticate
# before_filter :authenticate <-what is this syntax???
	# Instagram.configure do |config|
	# 	config.client_id = ENV['CLIENT_ID']
	# 	config.client_secret = ENV['CLIENT_SECRET']
	#end


# CALLBACK_URL = "http://localhost:3000"
	def index

	end


# 	get '/' do
#   redirect "https://instagram.com/oauth/authorize/?client_id=714ec5ab06844d288ee1637fcb8db711&redirect_uri=http://localhost:3000&response_type=code"
# end        



	def about
	end

	def contact
	end


# protected

# def authenticate
# 	authenticate_or_request_with_http_basic do |username, password|
# 		client_id == APP_CONFIG['client_id'] && client_secret == APP_CONFIG['client_secret']
# 	end
# end

# https://api.instagram.com/oauth/authorize/?client_id=client_id&redirect_uri=https://localhost:3000&response_type=code
end
