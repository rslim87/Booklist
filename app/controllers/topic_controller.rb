class TopicController < ApplicationController
	get '/topics' do 
		@topics = Topic.all 
		erb :'topics/index'
	end

	get '/topics/:id' do 
		@topic = Topic.find(params[:id])
		erb :'topics/show'
	end
end