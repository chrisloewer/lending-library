(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['add_book_form'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1, alias1=container.lambda, alias2=container.escapeExpression;

  return "<form class=\"add-book\" method=\"post\" action=\"/mw/add_book\">\n  <fieldset>\n    <label>Title: </label>\n    <input type=\"text\" name=\"title\" placeholder=\"Title\" value=\""
    + alias2(alias1(((stack1 = ((stack1 = ((stack1 = (depth0 != null ? depth0.items : depth0)) != null ? stack1["0"] : stack1)) != null ? stack1.volumeInfo : stack1)) != null ? stack1.title : stack1), depth0))
    + "\">\n  </fieldset>\n  <fieldset>\n    <label>Sub-Title: </label>\n    <input type=\"text\" name=\"subtitle\" placeholder=\"Sub-Title\" value=\""
    + alias2(alias1(((stack1 = ((stack1 = ((stack1 = (depth0 != null ? depth0.items : depth0)) != null ? stack1["0"] : stack1)) != null ? stack1.volumeInfo : stack1)) != null ? stack1.subtitle : stack1), depth0))
    + "\">\n  </fieldset>\n  <fieldset>\n    <label>Author: </label>\n    <input type=\"text\" name=\"author\" placeholder=\"Author\" value=\""
    + alias2(alias1(((stack1 = ((stack1 = ((stack1 = ((stack1 = (depth0 != null ? depth0.items : depth0)) != null ? stack1["0"] : stack1)) != null ? stack1.volumeInfo : stack1)) != null ? stack1.authors : stack1)) != null ? stack1["0"] : stack1), depth0))
    + "\">\n  </fieldset>\n  <fieldset>\n    <label>ISBN: </label>\n    <input type=\"text\" name=\"isbn\" placeholder=\"ISBN\" value=\""
    + alias2(alias1(((stack1 = ((stack1 = ((stack1 = ((stack1 = ((stack1 = (depth0 != null ? depth0.items : depth0)) != null ? stack1["0"] : stack1)) != null ? stack1.volumeInfo : stack1)) != null ? stack1.industryIdentifiers : stack1)) != null ? stack1["0"] : stack1)) != null ? stack1.identifier : stack1), depth0))
    + "\">\n  </fieldset>\n  <fieldset>\n    <label>Publication Year: </label>\n    <input type=\"text\" name=\"publication_year\" placeholder=\"Publication Year\" value=\""
    + alias2(alias1(((stack1 = ((stack1 = ((stack1 = (depth0 != null ? depth0.items : depth0)) != null ? stack1["0"] : stack1)) != null ? stack1.volumeInfo : stack1)) != null ? stack1.publishedDate : stack1), depth0))
    + "\">\n  </fieldset>\n\n  <fieldset>\n    <input  type=\"submit\" class=\"button-light button-small\" id=\"submitButton\" value=\"Add Book\">\n  </fieldset>\n</form>\n";
},"useData":true});
templates['library'] = template({"1":function(container,depth0,helpers,partials,data) {
    var alias1=container.lambda, alias2=container.escapeExpression;

  return "      <tr class=\"book-item\">\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.title : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.author : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.owner : depth0), depth0))
    + "</td>\n      </tr>\n";
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1;

  return "<div class=\"main-container\">\n  <h1>Your Library</h1>\n\n  <div class=\"button\">Add Book</div>\n\n  <table class=\"library-list\">\n    <tr>\n      <th>Title</th>\n      <th>Author</th>\n      <th>Owner</th>\n    </tr>\n\n"
    + ((stack1 = helpers.each.call(depth0,(depth0 != null ? depth0.books : depth0),{"name":"each","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
    + "  </table>\n</div>\n";
},"useData":true});
})();