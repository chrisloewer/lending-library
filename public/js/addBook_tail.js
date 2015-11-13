window.onload = function() {
  document.getElementById('submitButton').addEventListener('click', function() {
    var input = document.getElementById('isbnInput').value;
    insertTemplateByPath('add_book_form', 'add_book_form', '/api/google-api/isbn-info?isbn='+input);
  });
};
