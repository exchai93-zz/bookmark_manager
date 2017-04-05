require 'sinatra/base'
require_relative './models/link'
require 'data_mapper'

ENV['RACK_ENV']||= 'development'


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
    Link.create(url: params[:url], name: params[:name])
    redirect '/links'
  end

end
