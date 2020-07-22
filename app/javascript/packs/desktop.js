

$(document).on('ready turbolinks:load', function() {

  // Turn on all dropdowns.
  $('.ui.dropdown').dropdown();

  // Windows
  $('.ui.window').draggable({ handle: '.headbar' });


});
