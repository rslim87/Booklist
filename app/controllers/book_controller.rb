class BookController < ApplicationController

	get '/books' do 
		@books = Book.all 
		erb :"books/index"
	end

	get '/books/new' do 
		authenticate_user
		@book = book.new
		erb :"books/new"
	end

	post '/books' do 
		authenticate_user
		@book = current_user.books.build(params[:book])
		if @book.save
			if !params[:topic][:name].empty?
		  		@book.topics << Topic.create(name: params[:topic][:name])
			end
			redirect to "books/#{@book.id}"
		else 
			erb :'books/new'
		end
	end

	get '/books/:id' do 
		authenticate_user
		@book = Book.find_by_id(params[:id])	
		erb :'books/show'
	end

	get '/books/:id/edit' do 
		authenticate_user
		@book = Book.find_by_id(params[:id])
		if @book.user == current_user
			erb :'books/edit'
		else
			redirect to '/'
		end
	end

	patch '/books/:id' do 
		authenticate_user
		@book = current_user.books.find_by_id(params[:id])
		if @book 
    		if !params[:topic][:name].empty?
      			@book.topics << Topic.create(name: params["topic"]["name"])
    		end
    		@book.update(params[:book])
    		redirect "books/#{@book.id}"
    	else
    		redirect '/books'
    	end	
  	end

  	delete '/books/:id/delete' do 
  		authenticate_user
		@book = current_user.books.find_by_id(params[:id])
		if @book && @book.destory
			redirect '/books'
		else
			redirect "books/#{@book.id}"
		end
  	end

end
