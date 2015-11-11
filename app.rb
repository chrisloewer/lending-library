require 'sinatra'
require 'sinatra/cookies'
require 'sequel'
require 'json'
require 'open-uri'
require 'uri'
require 'tilt/erb'

require_relative('lib/user')
require_relative('lib/middleware')
require_relative('lib/database')

set :port, 23455
set :environment, :production


# ROUTING

get '/' do
  erb :landing_page
end

get '/library' do
  erb :library
end

get '/bookbag' do
  erb :bookbag
end

get '/signup' do
  erb :signup
end

get '/add-book' do
  erb :add_book
end


# API
get '/api/google-api/isbn-info' do
  isbn = params[:isbn]
  content = open("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}").read
  content
end

# User
post '/api/user/signup' do
  success, res = User.signup(params)
  if success
    cookies[:u_name] = res.name
    cookies[:u_token] = res.token
    erb :signup_success
  else
    @msg = res
    erb :signup_error
  end
end

post '/api/user/signin' do
  if user = User.login(params)
    cookies[:u_name] = user.name
    cookies[:u_token] = user.token
    puts 'Logged in successfully'
  else
    puts 'error logging in'
  end

  redirect '/'
end

get '/api/user/signout' do
  cookies.clear
  redirect '/'
end

def get_id
  return User.authenticate(cookies[:u_token])
end
