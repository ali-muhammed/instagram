class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy] 

	def new
		@post = post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save

			upload_picture

			redirect_to admin_posts_path
		else
			render 'new'
		end
	end

	def index
		@posts = Post.all
	end

	def destroy
		Post.destroy

		redirect_to admin_posts_path
	end

	def update

		if @post.update(post_params)
			upload_picture
			redirect_to admin_posts_path
		else
			render :edit
		end
	end

	private

	def post_params
		params.require(:post).permit()
	end 

	def upload_picture
		@post.picture.attach(uploaded_file) if uploaded_file.present?
	end

	def uploaded_file
		params[:post][:picture]
	end

	def find_post
		@post = Post.find(params[:id])
	end
end
