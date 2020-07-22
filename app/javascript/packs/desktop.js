

$(document).on('ready turbolinks:load', function() {

  // Turn on all dropdowns.
  $('.ui.dropdown').dropdown();

  // Windows
  $('.ui.window').draggable({ handle: '.headbar' });
  $('.ui.window').resizable(
    {
      animate: true,
      containment: 'body',
      helper: "window-resizer",
      minHeight: 200,
      minWidth: 300,
    }
  );


});
