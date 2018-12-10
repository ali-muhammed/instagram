class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = 'Welcome, your account has been created!'
			redirect_to users_path
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :description, :email, :password, :password_confirmation)
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
end
