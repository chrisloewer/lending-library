# Purpose: Frontend will make calls to this middleware, which in turn will make
# the appropriate action on the database

require 'open-uri'
require 'uri'
require 'date'
require 'json'

require_relative('database')
require_relative('../app')
require_relative('../lib/utilities')

Sequel::Model.plugin :json_serializer

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
  mw_getCurrentUserCheckouts
end

get '/api/mw/checkout-book' do
  mw_checkoutBook(params['book-id'])
end

get '/api/mw/return-book' do
  mw_returnBook(params['checkout-id'])
end


# DATABASE MIDDLEWARE

def mw_addBook(title, subtitle, author, isbn, publication_year, edition='', location='')

  user_id = get_id

  content = Database.addBook(
    sanitize_text(title),
    sanitize_text(subtitle),
    sanitize_text(author),
    sanitize_text(isbn),
    sanitize_text(edition),
    sanitize_text(publication_year),
    user_id,
    sanitize_text(location)
  )
  return content
end

def mw_removeBook(bookId)
  content = Database.removeBook(bookId)
  content.to_json.to_s
end

def mw_getBook(bookId)
  content = Database.getBook(bookId)  
  content.to_json.to_s
end

def mw_getBooks
  content = Database.getBooks
  content.to_json.to_s
end

def mw_getCurrentUserBooks
  content = mw_getUserBooks(get_id)
  content
end

def mw_getUserBooks(userId)
  content = Database.getUserBooks(userId)
  content.to_json.to_s
end

def mw_searchBooks(searchField, searchBy)

  return nil unless ['title', 'author', 'isbn', 'edition', 'publication_year', 'location'].include? searchField

  if searchField == 'title'
    content = Database.searchBooksByTitle(searchBy)
  else
    content = Database.searchBooks(searchField, searchBy)
  end 

  content.to_json.to_s
end


## Checkout Related
def mw_getCheckout(checkoutId)
  content = Database.getCheckout(checkoutId)
  content.to_json.to_s
end

def mw_getCurrentUserCheckouts
  mw_getUserCheckouts(get_id)
end

def mw_getUserCheckouts(userId)
  content = Database.getUserCheckouts(userId)
  content.to_json.to_s
end

def mw_getCheckouts
  content = Database.getCheckouts()
  content.to_json.to_s
end

def mw_checkoutBook(bookId)

  u_id = get_id

  current_time = DateTime.now
  # Add two weeks to the current date
  due_time = Time.now + (2*7*24*60*60)
  
  # Get the dates from the variables
  checkoutDate = current_time.strftime "%Y-%m-%d"
  dueDate = due_time.strftime "%Y-%m-%d"
  
  content = Database.checkoutBook(bookId, u_id, checkoutDate, dueDate)
  content.to_json.to_s
end

def mw_returnBook(checkoutId, returnCondition=0)
  current_time = DateTime.now

  returnDate = current_time.strftime '%Y-%m-%d'
  
  content = Database.returnBook(checkoutId, returnDate, returnCondition)
  content.to_json.to_s
end
# End Database Middleware
