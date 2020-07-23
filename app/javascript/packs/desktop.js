

$(document).on('ready turbolinks:load', function() {

  // Turn on all dropdowns.
  $('.ui.dropdown').dropdown();

  // Windows
  $('.ui.window').draggable({ 
    handle: '.headbar',
    containment: 'body'
  });
  $('.ui.window').resizable(
    {
      containment: 'body',
      helper: "window-resizer",
      minHeight: 200,
      minWidth: 400,
      stop: function(resize, ui) {
        var newHeight = ui.size.height - 16;
        $(ui.element[0]).children('div.ui.compact.segment').height(newHeight);
        var menuHeight = $(ui.element[0]).find('div.ui.top.attached.menu').first().outerHeight();
        $(ui.element[0]).children('div.ui.compact.segment').children('div.ui.bottom.attached.segment').height(newHeight - menuHeight - 28);
      }
    }
  );


});
