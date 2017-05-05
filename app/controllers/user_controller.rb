class UserController < ApplicationController

	get '/users/index' do
		erb :'users/index'
	end

	get '/signup' do 
		erb :'users/signup'
	end

	post '/signup' do 
		if params[:username] == "" || params[:password] == ""
      		redirect to '/signup'
    	else
      		@user = User.create(username: params["username"], password: params["password"], email: params["email"])

      	@user.save	
      	session[:user_id] = @user.id

      	redirect '/users/index'
      	end
    end

    get '/login' do 
    	erb :'users/login'
    end

    post '/login' do 
    	@user = User.find_by(username: params[:username])
    		if @user && @user.authenticate(params[:password])
      			session[:user_id] = @user.id
      		end
      			redirect to '/users/index'
      		
    end


end


