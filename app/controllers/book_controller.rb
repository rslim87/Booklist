class BookController < ApplicationController
	get '/books' do 
		@books = Book.all 
		erb :"books/index"
	end

	get '/books/new' do 
		erb :"books/new"
	end

	post '/books' do 
		if !params["topic"]["name"].empty?
      		@book.topics << Topic.create(name: params["topic"]["name"])
  		end
  		
  		@book = Book.create(params[:book])
  		@book.save

  		redirect to "books/#{@book.id}"

	end

	get '/books/:id' do 
		erb :'books/show'
	end
end
