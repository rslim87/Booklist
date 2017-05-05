class UserController < ApplicationController

	get '/signup' do 
		erb :'users/signup'
	end

	post '/signup' do 
		if params[:username] == "" || params[:password] == ""
      		redirect to '/signup'
    	else
      		@user = User.create(username: params["username"], password: params["password"], email: params["email"])

      	session[:user_id] = @user.id

      	redirect  "/"
      	end
    end


end 