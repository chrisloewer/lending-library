require 'sequel'

DB = Sequel.connect('sqlite://library.db')

Sequel::Model.plugin :json_serializer

# If you want to delete the tables and remake them change the ? to a !
# The ? makes tables if they don't exist
DB.create_table? :books do
  primary_key :book_id
  String :title, :text=>true
  String :subtitle, :text=>true
  String :author
  String :isbn
  String :edition
  String :publication_year
  Integer :user_id
  String :location
  String :book_status
end

DB.create_table? :checkouts do
  primary_key :checkout_id
  Integer :book_id
  Integer :user_id
  Date :checkout_date
  Date :due_date
  Date :return_date
  Integer :return_condition
end

DB.create_table? :@users do
  primary_key :user_id
  String :username
  String :email
  String :password
  String :password_reset_hash
  String :token
  Integer :permissions
  String :first_name
  String :last_name
  String :location
end

class Books < Sequel::Model
end

class Checkouts < Sequel::Model
end

class Users < Sequel::Model
end

class Database
  # Start Database API
  def self.addBook(title, subtitle, author, isbn, edition, publication_year, user_id, location)
    query = 'INSERT INTO books (title, subtitle, author, isbn, edition, publication_year, user_id, location, book_status)'
    query += " VALUES ('#{title}', '#{subtitle}', '#{author}', '#{isbn}', '#{edition}', '#{publication_year}', #{user_id}, '#{location}', 0)"
    DB.run(query)
  end

  def self.removeBook(book_id)
    query = "DELETE FROM books where book_id = #{book_id}"
    DB.run(query)
  end

  # Get Info for a Single Book
  def self.getBook(book_id)
    query = "SELECT b.*, u.username FROM books b join users u on u.user_id = b.user_id WHERE b.book_id = #{book_id}"
    returnValue(DB[query].all)
  end

  # Get all books in DB
  def self.getBooks
    query = 'SELECT b.*, u.username FROM books b join users u on u.user_id = b.user_id'
    returnValue(DB[query].all)
  end

  # Get all books a certain user owns
  def self.getUserBooks(user_id)
    query = "SELECT b.*, u.username FROM books b join users u on u.user_id = b.user_id WHERE b.user_id = #{user_id}"
    returnValue(DB[query].all)
  end

  # Search All books by a field and search text
  def self.searchBooks(search_field, search_by)
    query = "SELECT b.*, u.username FROM (books b join users u on u.user_id = b.user_id) where lower(b.#{search_field}) like '%#{search_by.downcase}%'"
    returnValue(DB[query].all)
  end

  # Search All books by titles
  def self.searchBooksByTitle(search_by)
    query = "SELECT b.*, u.username FROM (books b join users u on u.user_id = b.user_id) where lower(b.title) like '%#{search_by.downcase}%' or lower(b.subtitle) like '%#{search_by.downcase}%'"
    returnValue(DB[query].all)
  end

  ## Checkout Related
  def self.getCheckout(checkout_id)
    query = "SELECT c.*, b.title, b.subtitle, u.username FROM ((checkouts c ((join users u on u.user_id = b.user_id) join books b on b.book_id = c.book_id) WHERE c.checkout_id = #{checkout_id}"
    returnValue(DB[query].all)
  end

  def self.getUserCheckouts(user_id)
    query = "SELECT c.*, b.title, b.subtitle, u.username FROM ((checkouts c join users u on u.user_id = b.user_id) join books b on b.book_id = c.book_id) WHERE c.user_id = #{user_id}"
    returnValue(DB[query].all)
  end

  def self.getCheckouts
    query = 'SELECT c.*, b.title, b.subtitle, u.username FROM ((checkouts c join users u on u.user_id = b.user_id) join books b on b.book_id = c.book_id)'
    returnValue(DB[query].all)
  end

  def self.checkoutBook(book_id, user_id, checkout_date, due_date)
    query = "UPDATE books SET book_status = 1 WHERE book_id = #{book_id}"
    DB.run(query)
    query = "INSERT INTO checkouts (book_id, user_id, checkout_date, due_date) VALUES (#{book_id}, #{user_id}, '#{checkout_date}', '#{due_date}')"
    DB.run(query)
  end

  def self.returnBookBookId(book_id, return_date, return_condition)
    query = "UPDATE books SET book_status = 0 WHERE book_id = #{book_id}"
    DB.run(query)
    query = "UPDATE checkouts SET return_date = '#{return_date}', return_condition = #{return_condition} WHERE book_id = #{book_id} and return_date is null"
    DB.run(query)
  end

  def self.returnBookCheckoutId(checkout_id, return_date, return_condition)
    query = "UPDATE books SET book_status = 0 WHERE book_id = (select book_id from checkouts where checkout_id = #{checkout_id})"
    DB.run(query)
    query = "UPDATE checkouts SET return_date = '#{return_date}', return_condition = #{return_condition} WHERE checkout_id = #{checkout_id}"
    DB.run(query)
  end

  def self.returnValue(dataset)
    if dataset.count > 0
      return dataset
    else
      return nil
    end
  end

end
