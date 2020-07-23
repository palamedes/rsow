
$(document).on('ready turbolinks:load', function() {

  // Turn on all dropdowns.
  $('.ui.dropdown').dropdown();

  // Set Defaults for a resizable window
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

  // Set Defaults for a draggable window
  var draggableWindowArguments = {
    handle: '.headbar',
    containment: '.desktop'
  }

  // Make Windows Draggable and Resizable
  $('div.ui.window').draggable(draggableWindowArguments);
  $('div.ui.window').resizable(resizableWindowArguments);

  // Adjust the desktop to be the correct size
  var adjustDesktop = function() {
    var availableDesktopHeight = $(window).height() - $('.start-bar').outerHeight();
    $('div.desktop').height(availableDesktopHeight);
  }

  // After resizing window, resize the contents a tad.
  var adjustInternalWindowHeight = function($dis, height) {
    var newHeight = height - 11;
    $dis.find('div.ui.compact.segment').height(newHeight);
    var menuHeight = $dis.find('div.ui.top.attached.menu').first().outerHeight();
    $dis.find('div.ui.bottom.attached.segment').height(newHeight - menuHeight - 36);
  }

  // Set Window Height and Width
  var setWindowSize = function($window, height, width) {
    $window.height(height);
    $window.width(width);
    adjustInternalWindowHeight($window, height);
  }

  // Set Window Top and Left
  var setWindowPosition = function($window, top, left) {
    $window.css('top', top);
    $window.css('left', left);
  }

  // Here is how we restore a window
  var restoreWindow = function($window) {
    setWindowSize($window, 500,800);
    $('div.ui.window').resizable(resizableWindowArguments)
  }

  // Here is how we maximize a window
  var maximizeWindow = function($window) {
    setWindowPosition($window, 0, 0);
    var desktopHeight = $('div.desktop').height();
    var desktopWidth = $('div.desktop').width();
    setWindowSize($window, desktopHeight, desktopWidth);
  }

  /* Stuff to run once we are ready to */
  
  // Figure out how big our desktop actually is.. it's not the css size.
  adjustDesktop();
  // Really maximize any maximized windows
  maximizeWindow($('div.window.maximized'));


  /* Clickable Events */

  // RESTORE BUTTON at top right of window
  $('button.restore.window').click(function() {
    var $window = $(this).parents('div.ui.window');
    restoreWindow($window);
    $(this).siblings('.maximize').removeClass('hidden');
    $(this).addClass('hidden');
  });

  // RESTORE BUTTON at top right of window
  $('button.maximize.window').click(function() {
    var $window = $(this).parents('div.ui.window');
    maximizeWindow($window);
    $(this).siblings('.restore').removeClass('hidden');
    $(this).addClass('hidden');
  });


});
