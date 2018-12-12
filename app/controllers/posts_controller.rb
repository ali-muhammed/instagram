class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy] 

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		# @post.user_id = current_user.id
		if @post.save

			upload_picture

			redirect_to user_path(@post.user)
		else
			render 'new'
		end
	end

	def index
		@posts = Post.all
	end
 
	def destroy
		@post.destroy

		redirect_to user_path(@post.user)
		# можно и current_user
	end

	def update

		if @post.update(post_params)
			upload_picture
			redirect_to posts_path
		else
			render :edit
		end
	end

	private

	def post_params
		params.require(:post).permit(:description, :user_id) 
	end 

	def upload_picture
		@post.pictures.attach(uploaded_file) if uploaded_file.present?
	end

	def uploaded_file
		params[:post][:pictures]
	end

	def find_post
		@post = Post.find(params[:id])
	end
end
 