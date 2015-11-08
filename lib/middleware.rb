# Purpose: Frontend will make calls to this middleware, which in turn will make
# the appropriate action on the database

require 'open-uri'
require 'uri'
require 'date'

require_relative('../app')
require_relative('../lib/utilities')

# PUBLIC ROUTES

post '/api/mw/add-book' do
  mw_addBook(params[:title], params[:subtitle], params[:author], params[:isbn], params[:publication_year])
end

get '/api/mw/get-book' do
  book_id = params[:book_id]
  mw_getUserBooks(book_id)
end

get '/api/mw/get-books' do
  mw_getBooks
end

get '/api/mw/get-current-user-books' do
  mw_getCurrentUserBooks
end

get '/api/mw/search-books' do
  search_field = params[:search_field]
  search_by = params[:search_by]
  mw_searchBooks(search_field,search_by)
end

get '/api/mw/get-current-user-checkouts' do
  mw_getUserCheckouts(get_id)
end


# DATABASE MIDDLEWARE

def mw_addBook(title, subtitle, author, isbn, publication_year, edition='', location='')

  user_id = get_id

  uri = URI.parse("http://localhost:#{settings.port}/api/db/add-book")
  uri.query = URI.encode_www_form(
    'title' => sanitize_text(title),
    'subtitle' => sanitize_text(subtitle),
    'author' => sanitize_text(author),
    'isbn' => sanitize_text(isbn),
    'edition' => sanitize_text(edition),
    'publication_year' => sanitize_text(publication_year),
    'user_id' => user_id,
    'location' => sanitize_text(location)
  )
  content = open(uri.to_s).read
  return content
end

def mw_removeBook(bookId)
  content = open("http://localhost:#{settings.port}/api/db/remove-book?book_id=#{bookId}").read
  return content
end

def mw_getBook(bookId)
  content = open("http://localhost:#{settings.port}/api/db/get-book?book_id=#{bookId}").read
  return content
end

def mw_getBooks
  content = open("http://localhost:#{settings.port}/api/db/get-books").read
  return content
end

def mw_getCurrentUserBooks
  mw_getUserBooks(get_id)
end

def mw_getUserBooks(userId)
  content = open("http://localhost:#{settings.port}/api/db/get-user-books?user_id=#{userId}").read
  return content
end

def mw_searchBooks(searchField, searchBy)

  return nil unless ['title', 'author', 'isbn', 'edition', 'publication_year', 'location'].include? searchField

  if searchField == 'title'
    content = open("http://localhost:#{settings.port}/api/db/search-books-by-title?search_by=#{searchBy}").read
  else
    content = open("http://localhost:#{settings.port}/api/db/search-books?search_field=#{searchField}&search_by=#{searchBy}").read
  end 

  return content
end

## Checkout Related
def mw_getCheckout(checkoutId)
  content = open("http://localhost:#{settings.port}/api/db/get-checkout?checkout_id=#{checkoutId}").read
  return content
end

def mw_getUserCheckouts(userId)
  content = open("http://localhost:#{settings.port}/api/db/get-user-checkouts?user_id=#{userId}").read
  return content
end

def mw_getCheckouts
  content = open("http://localhost:#{settings.port}/api/db/get-checkouts").read
  return content
end

def mw_checkoutBook(bookId, userId)
  current_time = DateTime.now
  # Add two weeks to the current date
  due_time = Time.now + (2*7*24*60*60)
  

  # Get the dates from the variables
  checkoutDate = current_time.strftime "%Y-%m-%d"
  dueDate = due_time.strftime "%Y-%m-%d"
  
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

def mw_returnBook(checkoutId, returnCondition)
  current_time = DateTime.now

  returnDate = current_time.strftime '%Y-%m-%d'
  
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
