ENV['RACK_ENV']||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class Bookmark < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/users/new' do
    @user = User.new
    erb(:'users/user_form')
  end

  post '/users' do
    @user = User.new(email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:message] = "Password and confirmation do not match"
      erb :'users/user_form'
    end
  end

  get '/links' do
    @links = Link.all
    @user_count = User.all.count
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new_links')
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
    erb(:'links/index')
  end
end
