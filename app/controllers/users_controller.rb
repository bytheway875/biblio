class UsersController < ApplicationController
	def show
    @user = User.find(params[:id])
		@books = User.find(params[:id]).books
	end

  def index
    @users = User.all
  end
end