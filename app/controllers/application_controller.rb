require "pry"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/recipes" do
  	@recipes = Recipe.all
  	erb :index
  end

  get "/recipes/new" do
  	erb :new
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post "/recipes" do
  	p = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
  	redirect "/recipes/#{p.id}"
  end

  delete "/recipes/:id" do
    Recipe.find(params[:id]).destroy
    redirect "/recipes"
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id]) 
    erb :edit
  end

  patch "/recipes/:id" do
    r = Recipe.find(params[:id])
    r.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{r.id}"
  end


end
