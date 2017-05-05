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
		@book = Book.create(params[:book])
		if !params[:topic][:name].empty?
      		@book.topics << Topic.create(name: params[:topic][:name])
  		end
  		
  		
  		@book.save

  		redirect to "books/#{@book.id}"

	end

	get '/books/:id' do 
		if logged_in?
			@book = Book.find(params[:id])	
			erb :'books/show'
		else 
			redirect to '/login'
		end	
	end

	get '/books/:id/edit' do 
		if logged_in?
			@book = Book.find(params[:id])
			erb :'books/edit'
		else
			redirect to '/login'
		end
	end

	patch '/books/:id' do 
		@book = Book.find(params[:id])
   		@book.update(params["book"])
    	if !params["topic"]["name"].empty?
      		@book.topics << Topic.create(name: params["topic"]["name"])
    	end
    	redirect "books/#{@book.id}"
  	end

  	delete '/books/:id/delete' do 
  		if logged_in?
  			@book = Book.find(params[:id])
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
