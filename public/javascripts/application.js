// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function($) {
  $('#content').corner('bottom 12px');

  $('#question_answer').jqCounter({
    'maxChars'        : 5000,
    'maxCharsWarning' : 4900,
  });

  $('#question_text').jqCounter({
    'maxChars'        : 1000,
    'maxCharsWarning' : 900,
  });

  var flashBox = $('#flash')

  function notify(container) {
    container.show('slow');
    setTimeout(
      function(){
        container.hide('slow', function(){ container.html(''); });
      }, 3000
    );
  }

  flashBox.hide();
  if (flashBox.html() && flashBox.html().trim() != '') { notify(flashBox); }

});