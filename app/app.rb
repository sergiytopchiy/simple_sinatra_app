require 'sinatra'
require 'sinatra/activerecord'
require './app/models/user.rb'
require 'pry'

set :database, { adapter: 'postgresql',  encoding: 'unicode', database: 'sinapp', username: 'postgres' }

ALLOWED_USER_FIELDS = %w(first_name last_name age email)

after do
  ActiveRecord::Base.clear_active_connections!
end

get '/' do
  erb :index
end

get '/users/new' do
  erb :new
end

post '/users' do
  User.create!(params.slice(*ALLOWED_USER_FIELDS))
  redirect '/'
end

def name
  @name ||= session[:name]
end

def users
  @users ||= User.all
end