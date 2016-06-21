var PostShow = Backbone.View.extend({
  el: $("#post-show"),

  events: {
    "click .btn-move-page.scroll-top": "scrollTop",
    "click .btn-move-page.scroll-bottom": "scrollBottom",
    "click #replies .reply .btn-reply": "reply",
    "click .btn-focus-reply": "reply"
  },

  scrollTop: function() {
    $("body, html").animate({
      scrollTop: 0
    }, 300);
    return false;
  },

  scrollBottom: function() {
    let height = $('body').height();
    $("body, html").animate({
      scrollTop: height
    }, 300);
  },

  reply: function(e) {
    var _el = $(e.target);
    var floor = _el.data("floor");
    var login = _el.data("login");
    var reply_body = $(".medium-editor-insert-plugin");
    var new_text = '';
    if(floor) {
      new_text = "#"+ floor + "楼 @" + login + " ";

      var content = "<p class>" + new_text + "</p>";

      if (reply_body.find('p:last').html() == "<br>") {
        reply_body.find('p:last').html(content);
      } else {
        reply_body.find('.medium-insert-buttons').before(content);
      }
    } else {
      reply_body.focus();
    }

    return false;
  }

});

new PostShow;