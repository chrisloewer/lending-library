window.onload = function() {
  document.getElementById('submitButton').addEventListener('click', function() {
    var inputField = document.getElementById('searchField').value;
    var inputFor = document.getElementById('searchFor').value;
    insertTemplateByPath('list_book_form', 'book_list', '/api/mw/search-books?search_field='+inputField+'&search_by='+inputFor);
  });
};
