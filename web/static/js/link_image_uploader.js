import $ from "jquery"

var linkImageUploader = function () {
  $('#fileupload').fileupload({
    dataType: 'json',
    url: '/api/photos',
    done: function (e, data) {
      var file = data.result.files[0];
      var $img = $('<img/>').attr('src', file.url);
      $('#link_url').val(file.url).parents('.form-group').hide();
      $('#image-name').text(file.name);
      $('#new-link-image-name-display').show();
      $('#new-link-image-input').hide();
      $('#new-link-image-preview').html($img).show();
    }
  });

  $('.clear-input-button').on('click', function () {
    $('#link_url').val('').parents('.form-group').show();
    $('#image-name').text('');
    $('#new-link-image-name-display').hide();
    $('#new-link-image-preview').html('').hide();
    $('#new-link-image-input').show();
  });

  $('#link_url').keyup(function () {
    if ($(this).val().length > 0) {
      $('#newlink-with-image-upload').hide();
    } else {
      $('#newlink-with-image-upload').show();
    }

  });
}

linkImageUploader();

