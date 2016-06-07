import $ from "jquery"

$(function () {
  window.addEventListener('message', function(event) {
    // 接收位置信息，用户选择确认位置点后选点组件会触发该事件，回传用户的位置信息
    var loc = event.data;
    if (loc && loc.module == 'locationPicker') {//防止其他应用也会向该页面post信息，需判断module是否为'locationPicker'
      console.log('location', loc);
      console.log('location stringify', JSON.stringify(loc));
      loc.lat = loc.latlng.lat
      loc.lng = loc.latlng.lng
      delete loc.latlng
      $("#post_cityname").val(loc.cityname);
      $("#post_location").val(JSON.stringify(loc));
    }
  }, false);
});