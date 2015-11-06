# Purpose: Frontend will make calls to this middleware, which in turn will make
# the appropriate action on the database

require 'open-uri'
require 'uri'
require 'date'

# Start Database Middleware
def mwAddBook(title, subtitle, author, isbn, edition, publication_year, user_id, location)
  uri = URI.parse("http://localhost:#{settings.port}/api/db/add-book")
  uri.query = URI.encode_www_form(
    'title' => title,
    'subtitle' => subtitle,
    'author' => author,
    'isbn' => isbn,
    'edition' => edition,
    'publication_year' => publication_year,
    'user_id' => user_id,
    'location' => location
  )
  content = open(uri.to_s).read
  return content
end

def mwRemoveBook(book_id)
  content = open("http://localhost:#{settings.port}/api/db/remove-book?book_id=#{bookId}").read
  return content
end

get '/api/mw/get-book' do
  book_id = params[:book_id]  
  content = open("http://localhost:#{settings.port}/api/db/get-book?book_id=#{book_id}").read
  return content
end

get '/api/mw/get-books' do
  content = open("http://localhost:#{settings.port}/api/db/get-books").read
  return content
end

get '/api/mw/get-current-user-books' do
  user_id = get_id()
  content = open("http://localhost:#{settings.port}/api/db/get-user-books?user_id=#{user_id}").read
  return content
end

get '/api/mw/get-user-books' do
  user_id = params[:user_id]
  content = open("http://localhost:#{settings.port}/api/db/get-user-books?user_id=#{user_id}").read
  return content
end

get '/api/mw/search-books' do
  search_field = params[:search_field]
  search_by = params[:search_by]

  return nil unless ['title', 'author', 'isbn', 'edition', 'publication_year', 'location'].include? search_field

  if search_field == 'title'
    content = open("http://localhost:#{settings.port}/api/db/search-books-by-title?search_by=#{search_by}").read
  else
    content = open("http://localhost:#{settings.port}/api/db/search-books?search_field=#{search_field}&search_by=#{search_by}").read
  end 
  return content
end

## Checkout Related
get '/api/mw/get-checkout' do
  checkout_id = params[:checkout_id]
  content = open("http://localhost:#{settings.port}/api/db/get-checkout?checkout_id=#{checkout_id}").read
  return content
end

get '/api/mw/get-current-user-checkouts' do
  user_id = get_id()
  content = open("http://localhost:#{settings.port}/api/db/get-user-checkouts?user_id=#{user_id}").read
  return content
end

get '/api/mw/get-user-checkouts' do
  user_id = params[:user_id]
  content = open("http://localhost:#{settings.port}/api/db/get-user-checkouts?user_id=#{user_id}").read
  return content
end

get '/api/mw/get-checkouts' do
  content = open("http://localhost:#{settings.port}/api/db/get-checkouts").read
  return content
end

def mwCheckoutBook(book_id, user_id)
  current_time = DateTime.now
  # Add two weeks to the current date
  due_time = Time.now + (2*7*24*60*60)
  
  # Get the dates from the vareables
  checkout_date = current_time.strftime "%Y-%m-%d"
  due_date = due_time.strftime "%Y-%m-%d"
  
  uri = URI.parse("http://localhost:#{settings.port}/api/db/checkout-book")
  uri.query = URI.encode_www_form(
    'book_id' => bookId,
    'user_id' => userId,
    'checkout_date' => checkoutDate,
    'due_date' => dueDate
  )
  content = open(uri.to_s).read
  return content
end

def mwReturnBook(checkout_id, return_condition) 
  current_time = DateTime.now
  return_date = current_time.strftime "%Y-%m-%d"
  
  uri = URI.parse("http://localhost:#{settings.port}/api/db/return-book")
  uri.query = URI.encode_www_form(
    'checkout_id' => checkoutId,
    'return_date' => returnDate,
    'return_condition' => returnCondition
  )

  content = open(uri.to_s).read
  return content
end
# End Database Middleware
