class PostsController < ApplicationController

	def index
		@posts = Post.all
		@user = "USER NAME TO GO HERE EVENTUALLY...maybe"
	end

	def new  
		@post = Post.new
	end

	def create  
  @post = Post.create(post_params)
  redirect_to posts_path 
end 

private

def post_params  
  params.require(:post).permit(:image, :caption)
end 

end
