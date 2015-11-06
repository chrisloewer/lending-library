(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['bookbag'] = template({"1":function(container,depth0,helpers,partials,data) {
    return "  <table class=\"library-list\">\n    <tr>\n      <th>Title</th>\n      <th>Subtitle</th>\n      <th>Checkout Date</th>\n      <th>Due Date</th>\n      <th>Owner</th>      \n    </tr>\n";
},"3":function(container,depth0,helpers,partials,data) {
    var alias1=container.lambda, alias2=container.escapeExpression;

  return "      <tr class=\"book-item\">\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.title : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.subtitle : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.checkout_date : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.due_date : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.first_name : depth0), depth0))
    + " "
    + alias2(alias1((depth0 != null ? depth0.last_name : depth0), depth0))
    + "</td>\n      </tr>\n";
},"5":function(container,depth0,helpers,partials,data) {
    return "      <h3>You have no items in your Bookbag<h3>\n";
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1, alias1=depth0 != null ? depth0 : {};

  return "<div class=\"main-container\">\n  <h1>Your Bookbag</h1>\n  \n"
    + ((stack1 = helpers["if"].call(alias1,(depth0 != null ? depth0.length : depth0),{"name":"if","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
    + "\n"
    + ((stack1 = helpers.each.call(alias1,depth0,{"name":"each","hash":{},"fn":container.program(3, data, 0),"inverse":container.program(5, data, 0),"data":data})) != null ? stack1 : "")
    + "  </table>\n</div>\n";
},"useData":true});
templates['library'] = template({"1":function(container,depth0,helpers,partials,data) {
    return "    <table class=\"library-list\">\n      <tr>\n        <th>Title</th>\n        <th>Subtitle</th>\n        <th>Author</th>\n        <th>Edition</th>\n        <th>Publication Year</th>\n      </tr>\n";
},"3":function(container,depth0,helpers,partials,data) {
    var alias1=container.lambda, alias2=container.escapeExpression;

  return "      <tr class=\"book-item\">\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.title : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.subtitle : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.author : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.edition : depth0), depth0))
    + "</td>\n        <td>"
    + alias2(alias1((depth0 != null ? depth0.publication_year : depth0), depth0))
    + "</td>\n      </tr>\n";
},"5":function(container,depth0,helpers,partials,data) {
    return "      <h3>You have no items in your Library<h3>\n";
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1, alias1=depth0 != null ? depth0 : {};

  return "<div class=\"main-container\">\n  <h1>Your Library</h1>\n\n  <div class=\"button\">Add Book</div>\n\n\n"
    + ((stack1 = helpers["if"].call(alias1,(depth0 != null ? depth0.length : depth0),{"name":"if","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
    + "\n"
    + ((stack1 = helpers.each.call(alias1,depth0,{"name":"each","hash":{},"fn":container.program(3, data, 0),"inverse":container.program(5, data, 0),"data":data})) != null ? stack1 : "")
    + "  </table>\n</div>\n";
},"useData":true});
})();