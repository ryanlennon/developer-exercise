var Quote = Backbone.Model.extend({
  defaults: {
    quote: "",
    context: "",
    source: "",
    theme: ""
  }
});

var QuoteList = Backbone.Collection.extend({
  model: Quote,
  url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json'
});

var QuoteView = Backbone.View.extend({
  el: "#quotes",
  template: _.template($('#quoteTemplate').html()),
  render: function(eventName) {
    _.each(this.model.models, function(quote) {
      var quoteTemplate = this.template(quote.toJSON());
      $(this.el).append(quoteTemplate);
    }, this);
    return this;
  }
});

var quotes = new QuoteList();
var quotesView = new QuoteView({model: quotes});
quotes.fetch({
  success: function() {
    quotesView.render();
  }
});