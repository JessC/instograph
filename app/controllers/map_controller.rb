class MapController < ApplicationController

	CALLBACK_URL = "http://localhost:3000/map/callback"
# 2. CALLBACK - routes here after user give oauth info to instagram

	def connect
		redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
# 1. ask for user to login to instagram upon navigating to this page by clicking map
	end

	def callback
		response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
# 3. response is set to authorization tokens we get back and then we send them back
	  session[:access_token] = response.access_token
# 4. our session is set to the authorization tokes
	  redirect_to map_index_path
# 5. gets access token and redirects to map/index
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
			render :index
	end     




# # return array with all the images in user media
def usersfeed
	p "**users feed**"*15
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
#    html = "<h1>#{user.username}'s media feed</h1>"

#   page_1 = client.user_media_feed(777)
#   page_2_max_id = page_1.pagination.next_max_id
#   page_2 = client.user_recent_media(777, :max_id => page_2_max_id ) unless page_2_max_id.nil?
#   html << "<h2>Page 1</h2><br/>"
#   for media_item in page_1
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html << "<h2>Page 2</h2><br/>"
#   for media_item in page_2
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

# get "/users/self/feed" do

#   client = Instagram.client(access_token: session[:access_token])
#   user = client.user

  image_container = []
  count = 0
  next_max_id = nil
  while count < user.counts.media do
    if next_max_id != nil
      current_page = client.user_recent_media(user.id, {count: 33, max_id: next_max_id})
    else
      current_page = client.user_recent_media(user.id, {count: 33})
    end
    next_max_id = current_page.pagination.next_max_id
    current_page.each do |image|
      if image["location"]
        if image["location"]["latitude"]
        image_container << {
          url: image.images.standard_resolution.url,
          thumbnail: image.images.thumbnail.url,
          location: image.location,
          tags: image.tags,
          username: image.user.username,
          }
        end
      end
    end
    p "current page count is:"
    count += current_page.count
  end
  p "THIS IS MY JSON RESPONSE"
  p image_container.to_json
  	respond_to do |format|
			if image_container
			    format.json { render :json => image_container }
			    format.html {redirect_to '/'}
			else
			    format.html { redirect_to map }
          format.json { render :json => image_container.errors.full_messages, :status => :unprocessable_entity }
			end
		end
end

# return array with first 100 geotagged images of news feed
def mediafeed 
		puts "**media feed**"*15
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
  image_container = []

  count = 0
  next_max_id = nil
  while image_container.count < 10 do
    if next_max_id != nil
      current_page = client.user_media_feed({count: 5, max_id: next_max_id})
    else
      current_page = client.user_media_feed({count: 5})
    end
    next_max_id = current_page.pagination.next_max_id
    current_page.each do |image|
      pp image
      if image["location"]
        if image["location"]["latitude"]
        image_container << {
          url: image.images.standard_resolution.url,
          thumbnail: image.images.thumbnail.url,
          location: image.location,
          tags: image.tags,
          username: image.user.username,
          }
        end
      end
    end
    count += current_page.count
    p "current page count is:"
    p count
  end
	p "THIS IS MY JSON CONTAINER"
  p image_container.to_json
	respond_to do |format|
			if image_container
			      format.json { render :json => image_container }
			      format.html {redirect_to '/'}
			else
			 format.html { redirect_to map }
       format.json { render :json => image_container.errors.full_messages, :status => :unprocessable_entity }
			end
		end
end

# REFERENCE:
# get "/user_search" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Search for users on instagram, by name or usernames</h1>"
#   for user in client.user_search("instagram")
#     html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
#   end
#   html
# end

# get "/location_search" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Search for a location by lat/lng with a radius of 5000m</h1>"
#   for location in client.location_search("48.858844","2.294351","5000")
#     html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
#   end
#   html
# end

# get "/sessions/logout" do
#   session["access_token"] = nil
#   session["session_id"] = nil
#   redirect "/"
# end

# get '/media_like/:id' do
#   client = Instagram.client(:access_token => session[:access_token])
#   client.like_media("#{params[:id]}")
# end

# get '/media_unlike/:id' do
#   client = Instagram.client(:access_token => session[:access_token])
#   client.unlike_media("#{params[:id]}")
# end


	# def show

	# end


	# protected

	# def authenticate
	# 	authenticate_or_request_with_http_basic do |username, password|
	# 		client_id == APP_CONFIG['client_id'] && client_secret == APP_CONFIG['client_secret']
	# 	end
	# end

end















# get "/user_recent_media" do
#   client = Instagram.client(:access_token => session[:access_token])
#   user = client.user
#   html = "<h1>#{user.username}'s recent media</h1>"
#   for media_item in client.user_recent_media
#     html << "<div style='float:left;'><img src='#{media_item.images.thumbnail.url}'><br/> <a href='/media_like/#{media_item.id}'>Like</a>  <a href='/media_unlike/#{media_item.id}'>Un-Like</a>  <br/>LikesCount=#{media_item.likes[:count]}</div>"
#   end
#   html
# end

# get '/media_like/:id' do
#   client = Instagram.client(:access_token => session[:access_token])
#   client.like_media("#{params[:id]}")
#   redirect "/user_recent_media"
# end

# get '/media_unlike/:id' do
#   client = Instagram.client(:access_token => session[:access_token])
#   client.unlike_media("#{params[:id]}")
#   redirect "/user_recent_media"
# end

# get "/user_media_feed" do
#   client = Instagram.client(:access_token => session[:access_token])
#   user = client.user
#   html = "<h1>#{user.username}'s media feed</h1>"

#   page_1 = client.user_media_feed(777)
#   page_2_max_id = page_1.pagination.next_max_id
#   page_2 = client.user_recent_media(777, :max_id => page_2_max_id ) unless page_2_max_id.nil?
#   html << "<h2>Page 1</h2><br/>"
#   for media_item in page_1
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html << "<h2>Page 2</h2><br/>"
#   for media_item in page_2
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

# get "/location_recent_media" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Media from the Instagram Office</h1>"
#   for media_item in client.location_recent_media(514276)
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

# get "/media_search" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Get a list of media close to a given latitude and longitude</h1>"
#   for media_item in client.media_search("37.7808851","-122.3948632")
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

# get "/media_popular" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Get a list of the overall most popular media items</h1>"
#   for media_item in client.media_popular
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

# get "/user_search" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Search for users on instagram, by name or usernames</h1>"
#   for user in client.user_search("instagram")
#     html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
#   end
#   html
# end

# get "/location_search" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Search for a location by lat/lng with a radius of 5000m</h1>"
#   for location in client.location_search("48.858844","2.294351","5000")
#     html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
#   end
#   html
# end

# get "/location_search_4square" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Search for a location by Fousquare ID (v2)</h1>"
#   for location in client.location_search("3fd66200f964a520c5f11ee3")
#     html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
#   end
#   html
# end

# get "/tags" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1>Search for tags, get tag info and get media by tag</h1>"
#   tags = client.tag_search('cat')
#   html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
#   for media_item in client.tag_recent_media(tags[0].name)
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

# get "/limits" do
#   client = Instagram.client(:access_token => session[:access_token])
#   html = "<h1/>View API Rate Limit and calls remaining</h1>"
#   response = client.utils_raw_response
#   html << "Rate Limit = #{response.headers[:x_ratelimit_limit]}.  <br/>Calls Remaining = #{response.headers[:x_ratelimit_remaining]}"

#   html
# end