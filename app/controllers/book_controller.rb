class BookController < ApplicationController
	get '/books' do 
		@books = Book.all 
		erb :"/books/index"
	end
end
