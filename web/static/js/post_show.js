var PostShow = Backbone.View.extend({
  el: $("#post-show"),

  events: {
    "click .btn-move-page.scroll-top": "scrollTop",
    "click .btn-move-page.scroll-bottom": "scrollBottom",
    "click #replies .reply .btn-reply": "reply",
    "click .btn-focus-reply": "reply",
    "click a.likeable.like-post": "likePost",
    "click a.likeable.like-comment": "likeComment"
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
  },

  likePost: function(e) {
    let post_id = $(e.currentTarget).data("id");
    $.post("/like_post/"+post_id, function(data) {
      $('a.likeable.like-post').toggleClass("active");
      $('a.likeable.like-post i').toggleClass("fa-heart fa-heart-o");

      if(data.likes_count > 0) {
        $('a.likeable.like-post span').html(data.likes_count + " 个赞");
      } else {
        $('a.likeable.like-post span').html("");
      }
    });
    return false;
  },

  likeComment: function(e) {
    let comment_id = $(e.currentTarget).data("id");
    $.post("/like_comment/"+comment_id, function(data) {
      $(e.currentTarget).toggleClass("active");
      $(e.currentTarget).find('i').toggleClass("fa-heart fa-heart-o");

      if(data.likes_count > 0) {
        $("#comment-"+data.comment_id).find('a.likeable.like-comment span').html(data.likes_count + " 个赞");
      } else {
        $("#comment-"+data.comment_id).find('a.likeable.like-comment span').html("");
      }
    });
    return false;
  }

});

new PostShow;