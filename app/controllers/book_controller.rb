class BookController < ApplicationController
	get '/books' do 
		@books = Book.all 
		erb :"books/index"
	end

	get '/books/new' do 
		erb :"books/new"
	end

	post '/books' do 
		@book = Book.create(params[:book])
		if !params["topic"]["name"].empty?
      		@book.topics << Topic.create(name: params["topic"]["name"])
  		end
  		
  		
  		@book.save

  		redirect to "books/#{@book.id}"

	end

	get '/books/:id' do 
		@book = Book.find(params[:id])	
		erb :'books/show'
	end
end
