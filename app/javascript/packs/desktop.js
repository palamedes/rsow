
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
      adjustInternalWindowHeight($(this), ui.size.height);
    },
    stop: function(resize, ui) {
      adjustInternalWindowHeight($(this), ui.size.height);
      setWindowLocationData($(this));
    }
  }

  // Set Defaults for a draggable window
  var draggableWindowArguments = {
    handle: '.headbar',
    containment: '.desktop',
    stop: function(drag, ui) {
      setWindowLocationData($(this));
    }
  }

  // Make Windows Draggable and Resizable
  $('div.ui.window').draggable(draggableWindowArguments);
  $('div.ui.window').resizable(resizableWindowArguments);

  // Adjust the desktop to be the correct size
  var adjustDesktop = function() {
    var availableDesktopHeight = $(window).height() - $('.start-bar').outerHeight();
    $('div.desktop').height(availableDesktopHeight);
  }

  // After resizing window, resize the contents a tad because this can't be done with CSS
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
    var windowLocation = getWindowLocationData($window);
    setWindowPosition($window, windowLocation['top'], windowLocation['left']);
    setWindowSize($window, windowLocation['height'], windowLocation['width']);
    $('div.ui.window').resizable(resizableWindowArguments)
  }

  // Here is how we maximize a window
  var maximizeWindow = function($window) {
    setWindowPosition($window, 0, 0);
    var desktopHeight = $('div.desktop').height();
    var desktopWidth = $('div.desktop').width();
    setWindowSize($window, desktopHeight, desktopWidth);
  }

  // Store the window location data in the data of the window object for use later
  var setWindowLocationData = function($window) {
    $window.data('top', $window.position()['top']);
    $window.data('left', $window.position()['left']);
    $window.data('width', $window.width());
    $window.data('height', $window.height());
  }
  // Get the window location and return it
  var getWindowLocationData = function($window) {
    return {
      'top': $window.data('top') || 0,
      'left' : $window.data('left') || 0,
      'width' : $window.data('width') || 800,
      'height' : $window.data('height') || 500
    }
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
  
  // @TODO if the window changes size, update the desktop size and redraw state of all windows so they fit accordingly.

  // @TODO handle small views so we are no longer a window system if we get too small (mobile etc..)
  
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
    setWindowLocationData($window);
    maximizeWindow($window);
    $(this).siblings('.restore').removeClass('hidden');
    $(this).addClass('hidden');
  });


});
