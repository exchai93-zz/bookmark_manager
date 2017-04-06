ENV['RACK_ENV']||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'

class Bookmark < Sinatra::Base

  enable :sessions

  get '/' do
    erb(:index)
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    @user_count = User.all.count
    erb(:links)
  end

  get '/links/new' do
    erb(:new_links)
  end

  post '/links' do
    link = Link.new(url: params[:url],
                  name: params[:name])

    tags = params[:tags].split(' ')

    tags.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tag/:filter_tag' do
    tag = Tag.first(name: params[:filter_tag])
    @links = tag ? tag.links : []
    erb(:links)
  end

  get '/signup' do
    erb(:signup)
  end

  post '/signup' do
    User.create(email: params[:email], password: params[:password])
    redirect '/links'
  end

end
