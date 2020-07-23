
$(document).on('ready turbolinks:load', function() {

  // Turn on all dropdowns.
  $('.ui.dropdown').dropdown();

  var resizableWindowArguments = {
    containment: '.desktop',
    minHeight: 200,
    minWidth: 400,
    handles: 'se',
    resize: function(resize, ui) {
      adjustInternalWindowHeight($(ui.element[0]), ui.size.height);
    },
    stop: function(resize, ui) {
      adjustInternalWindowHeight($(ui.element[0]), ui.size.height);
    }
  }
  // Windows
  $('div.ui.window').draggable({
    handle: '.headbar',
    containment: '.desktop'
  });
  $('div.ui.window').resizable(resizableWindowArguments);

  // After resizing window, resize the contents a tad.
  var adjustInternalWindowHeight = function($dis, height) {
    var newHeight = height - 11;
    $dis.find('div.ui.compact.segment').height(newHeight);
    var menuHeight = $dis.find('div.ui.top.attached.menu').first().outerHeight();
    $dis.find('div.ui.bottom.attached.segment').height(newHeight - menuHeight - 36);
  }

  // Set WindowSize
  var setWindowSize = function($window, height, width) {
    $window.height(height);
    $window.width(width);
    adjustInternalWindowHeight($window, height);
  }

  // RESTORE BUTTON at top right of window
  $('button.restore.window').click(function() {
    restoreWindow($(this).parents('div.ui.window'));
  });

  // Here is how we restore a window
  var restoreWindow = function($window) {
    setWindowSize($window, 500,800);
    $('div.ui.window').resizable(resizableWindowArguments)
  }

});
