// import $ from "jquery"

$(function(){
  window.addEventListener('message', function(event){
    var loc = event.data;
    if (loc && loc.module == 'locationPicker') {//防止其他应用也会向该页面post信息，需判断module是否为'locationPicker'
      console.log('location', loc);
      console.log('location stringify', JSON.stringify(loc));
      loc.lat = loc.latlng.lat
      loc.lng = loc.latlng.lng
      delete loc.latlng
      $("#post_cityname").val(loc.cityname);
      $("#post_location").val(JSON.stringify(loc));

      $("#added-location").html("<span id=\"cityname\">"+loc.cityname+"</span><a id=\"remove-location\" href=\"javascript:;\"><i>&times;</i></a>")

    }
  }, false);
});

var PostForm = Backbone.View.extend({
  el: $("#post-form"),

  events: {
    "click #remove-location" : "removeLocation"
  },

  initialize: function () {
    this.$location = this.$("#added-location");
    this.$post_cityname = this.$("#post_cityname");
    this.$post_location = this.$("#post_location");
  },

  render: function() {
    return this;
  },

  removeLocation: function() {
    if (this.$location) {
      this.$location.html("");
    }
    this.$post_cityname.val("");
    this.$post_location.val("null");
  }
});


new PostForm;