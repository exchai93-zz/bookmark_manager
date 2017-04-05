ENV['RACK_ENV']||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'



class Bookmark < Sinatra::Base


  get '/' do
    erb(:index)
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:new_links)
  end

  post '/links' do
    link = Link.new(url: params[:url],
                  name: params[:name])
    tag = Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
    redirect '/links'
  end

end
