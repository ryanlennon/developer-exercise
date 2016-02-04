var page;

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
    url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
    paginate: function(itemsOnPage, page) {}
  });

  var QuoteView = Backbone.View.extend({
    
        $(this.el).append(lTemplate);
      }, this);
      return this;
    }
  });

  var lQuotes = new QuoteList;

  var AppView = Backbone.View.extend({
    el: "body",

    render: function() {
      var lQuotesView = new lQuotesView({model:lQuotes});
      var lHtml = lQuotesView.render().el;
      $('#quotes').html(lHtml);
    },

    initailize:function() {
      var lOptions = {};
      lOptions.success = this.render;
      lQuotes.fetch(lOptions);
    }
  });
  var App = new AppView;