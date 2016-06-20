var PostShow = Backbone.View.extend({
  el: $("#topic-sidebar"),

  events: {
    "click .btn-move-page": "scrollPage"
  },

  scrollPage: function(e) {
    var target = $(e.currentTarget);
    var moveType = target.data('type');
    var opts = {
      scrollTop: 0
    }
    if (moveType == 'bottom') {
      opts.scrollTop = $('body').height();
    }
    $("body, html").animate(opts, 300);
    return false;
  }

});

new PostShow;