import $ from "jquery"

let richEidtor = function () {
  let editor = new MediumEditor('.editable', {
    toolbar: {
      buttons: ['bold', 'italic', 'underline', 'anchor', 'strikethrough', 'anchor', 'quote', 'removeFormat']
    }
  });

  $('.editable').mediumInsert({
      editor: editor
  });
}

export default richEidtor