import $ from "jquery"


var richEditor = new MediumEditor('.editable', {
  toolbar: {
    buttons: ['bold', 'italic', 'underline', 'anchor', 'strikethrough', 'anchor', 'quote', 'removeFormat']
  },
  placeholder: false
});

export function postEditor () {
  $('.post-editable').mediumInsert({
    editor: richEditor
  });
}

export function commentEditor() {
  $('.comment-editable').mediumInsert({
    editor: richEditor
  });
}

export default richEditor;