class ApplicationController < Sinatra::Base

	configure do 
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
    	set :session_secret, "book_list_secret"
	end

	get '/' do 
		erb :index
	end

	

end