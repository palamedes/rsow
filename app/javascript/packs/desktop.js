
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

    // @TODO check to see if we have a stored location and size of window, if we do.. use that.

    setWindowSize($window, 500,800);
    $('div.ui.window').resizable(resizableWindowArguments)
  }

  // Here is how we maximize a window
  var maximizeWindow = function($window) {

    // @TODO Store the windows current location and size so that on restore we can use it

    setWindowPosition($window, 0, 0);
    var desktopHeight = $('div.desktop').height();
    var desktopWidth = $('div.desktop').width();
    setWindowSize($window, desktopHeight, desktopWidth);
  }

  // @TODO json call to get a new window of content

  // @TODO start bar buttons should TRY to pull via JSON

  // @TODO X window button should close the window, and if we are at that location then we should default back
  // to desktop cleanly without other windows closing.

  // @TODO Minimize window should effectively close the window or "minimize" it, but leave an item in the
  // start bar letting people know that that window had been opened.  If it's an already existing static button
  // like the about page, then it should just highlight that button as if it were still open.

  // @TODO Slug of open window should find the associated button in the start bar and highlight it.
  // @TODO If there is no existing button that corresponds to the opened window, add one and that's now your
  // new app icon for that instance of that window.

  // @TODO Question mark top right should give you some information about the window you have opened.. that means
  // each window could have different or similar information based on what the information is.  Or defined by MD?

  // @TODO Be able to set minimum window width/height dynamically in the .md
  
  
  
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
