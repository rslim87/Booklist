class BookController < ApplicationController
	get '/books' do 
		@books = Book.all 
		erb :"books/index"
	end

	get '/books/new' do 
		if logged_in?
			erb :"books/new"
		else
			redirect to '/login'
		end 
	end

	post '/books' do 
		@book = current_user.books.create(params[:book])
		if !params[:topic][:name].empty?
      		@book.topics << Topic.create(name: params[:topic][:name])
  		end
  		redirect to "books/#{@book.id}"
	end

	get '/books/:id' do 
		if logged_in?
			@book = Book.find_by_id(params[:id])	
			erb :'books/show'
		else 
			redirect to '/login'
		end	
	end

	get '/books/:id/edit' do 
		if logged_in?
			@book = Book.find_by_id(params[:id])
			if @book.user_id == current_user.id
				erb :'books/edit'
			else
				redirect to '/'
			end
		else
			redirect to '/login'
		end
	end

	patch '/books/:id' do 
		@book = current_user.books.find_by_id(params[:id])
		if @book 
   			@book.update(params[:book])
    			if !params[:topic][:name].empty?
      				@book.topics << Topic.create(name: params["topic"]["name"])
    			end
    		redirect "books/#{@book.id}"
    	else
    		redirect '/books'
    	end	
  	end

  	delete '/books/:id/delete' do 
  		if logged_in?
  			@book = Book.find_by_id(params[:id])
  			if @book.user_id == current_user.id
  				@book.delete
  				redirect '/books'
  			else
  				redirect to '/books'
  			end
  		else
  			redirect to '/login'
  		end
  	end

end
