class BooksController < ApplicationController
	def show
		@books = @current_user.books
	end
end