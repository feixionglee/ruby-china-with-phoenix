$(function(){
  var engine = new Bloodhound({
    // local: ['dog', 'pig', 'moose'],
    remote: '/api/tags/autocomplete',
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace
  });

  engine.initialize();

  $('#link_tags').tokenfield({
    typeahead: [null, { source: engine.ttAdapter() }]
  });

  // $('#link_tags').tokenfield();
});


