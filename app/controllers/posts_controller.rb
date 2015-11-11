class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

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

def show
  @post = Post.find(params[:id])
end

def edit  
	@post = Post.find(params[:id])
end   

def update  
	@post = Post.find(params[:id])
	@post.update(post_params)
	redirect_to(post_path(@post))
end  

def destroy 
	@post = Post.find(params[:id])
	@post.destroy
	redirect_to posts_path
end  

private

def post_params  
	params.require(:post).permit(:image, :caption)
end

def set_s3_direct_post
  @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
end

end
