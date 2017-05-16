class UserController < ApplicationController

  get '/users/index' do
    erb :'users/index'
  end

	get '/signup' do 
		erb :'users/signup'
	end

	post '/signup' do 
    @user = User.new(username: params["username"], password: params["password"], email: params["email"])
    if @user.save	
      session[:user_id] = @user.id
      redirect '/login'
    else 
      redirect to '/signup'
    end
  end

  get '/login' do 
    if !logged_in?
    	erb :'users/login'
    else
    	redirect '/users/index'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/users/index' 	
    else 
      redirect to '/login'	
    end	
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end


