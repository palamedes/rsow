$(document).on('ready turbolinks:load', function() {

  /** SLUG FUNCTIONS
   *  Okay these are unique in that some slugs will have custom code..  that code goes here and will be called
   *  when the slug is loaded.. but only when it's loaded.
   */
  var slugFunctions = [];

  // Turn on all dropdowns.
  $('.ui.dropdown').dropdown();

  // Set Defaults for a resizable window
  var resizableWindowArguments = {
    containment: '.desktop',
    minHeight: 400,
    minWidth: 700,
    handles: 'se',
    resize: function(resize, ui) {
      adjustInternalWindowHeight($(this), ui.size.height);
      // If this was previously maximized, remove that status
      $(this).removeClass('maximized');
      $(this).find('button.restore.window').addClass('hidden');
      $(this).find('button.maximize.window').removeClass('hidden');
      // Pop State from History
      history.pushState({}, "", "/");
    },
    stop: function(resize, ui) {
      adjustInternalWindowHeight($(this), ui.size.height);
      setWindowLocationData($(this));
    }
  };

  // Set Defaults for a draggable window
  var draggableWindowArguments = {
    handle: '.headbar',
    containment: '.desktop',
    start: function(drag, ui) {
      bringToFront($(this));
    },
    stop: function(drag, ui) {
      if (!$(this).hasClass('maximized')) {
        setWindowLocationData($(this));
      }
    }
  };

  // Make Windows Draggable and Resizable
  $('div.ui.window').draggable(draggableWindowArguments);
  $('div.ui.window').resizable(resizableWindowArguments);

  // Adjust the desktop to be the correct size
  var adjustDesktop = function() {
    var availableDesktopHeight = $(window).height() - $('.start-bar').outerHeight();
    $('div.desktop').height(availableDesktopHeight);
  };

  // After resizing window, resize the contents a tad because this can't be done with CSS
  var adjustInternalWindowHeight = function($dis, height) {
    var newHeight = height - 11;
    $dis.find('div.ui.compact.segment').height(newHeight);
    var menuHeight = $dis.find('div.ui.top.attached.menu').first().outerHeight();
    $dis.find('div.ui.bottom.attached.segment').height(newHeight - menuHeight - 36);
  };

  // Set Window Height and Width
  var setWindowSize = function($window, height, width) {
    $window.height(height);
    $window.width(width);
    adjustInternalWindowHeight($window, height);
  };

  // Set Window Top and Left
  var setWindowPosition = function($window, top, left) {
    $window.css('top', top);
    $window.css('left', left);
  };

  // This is how we bring windows to the fore
  var bringToFront = function(dis) {
    $('div.window').css('zIndex', 1);
    $(dis).css('zIndex', 10);
  };

  // Here is how we restore a window
  var restoreWindow = function($window) {
    if ($window.length) {
      // Remove class
      $window.removeClass('maximized');
      // Get the location data from the window
      var windowLocation = getWindowLocationData($window);
      // Set it..
      setWindowPosition($window, windowLocation['top'], windowLocation['left']);
      setWindowSize($window, windowLocation['height'], windowLocation['width']);
      // Pop State from History
      history.pushState({}, "", "/");
      // Update header buttons accordingly
      $window.find('button.maximize').removeClass('hidden');
      $window.find('button.restore').addClass('hidden');
    }
  };

  // Here is how we maximize a window
  var maximizeWindow = function($window) {
    if ($window.length) {
      // Add class
      $window.addClass('maximized');
      // Set window position and size
      setWindowPosition($window, 5, 5);
      var desktopHeight = $('div.desktop').height();
      var desktopWidth = $('div.desktop').width();
      setWindowSize($window, desktopHeight, desktopWidth);
      // Push State and look for magic work "blog-" to make sure it gets slashed
      var loc = $window.attr('id').replace('blog-', 'blog/');
      history.pushState({}, $window.find('.active.header.item').html().trim(), "/"+loc)
      // Update header buttons accordingly
      $window.find('button.restore').removeClass('hidden');
      $window.find('button.maximize').addClass('hidden');
    }
  };

  // Store the window location data in the data of the window object for use later
  var setWindowLocationData = function($window) {
    if ($window.length) {
      $window.data('top', $window.position()['top']);
      $window.data('left', $window.position()['left']);
      $window.data('width', $window.width());
      $window.data('height', $window.height());
    }
  };
  // Get the window location and return it
  var getWindowLocationData = function($window) {
    if ($window.length) {
      return {
        'top': $window.data('top') || 5,
        'left' : $window.data('left') || 5,
        'width' : $window.data('width') || 800,
        'height' : $window.data('height') || 500
      }
    } else {
      return { 'top': 5, 'left': 5, 'width': 800, 'height': 500 }
    }
  };

  // Iterate through each window open.. Find the start bar link for it and make sure that is set to active.
  var updateStartbarLinks = function(data) {
    // First set all task bar items that have a window to active
    $('div.window').each(function() {
      var slug = $(this).data('slug');
      if ($('div.start-bar a.item[data-slug='+slug+']').length) {
        $('div.start-bar a.item[data-slug='+slug+']').addClass('active');
      } else {
        var html = '<a href="'+$(this).data('slug')+'" class="item active" data-slug="'+$(this).data('slug')+'"><i class="'+$(this).data('icon')+' icon"></i>'+$(this).data('title')+'</a>';
        $(html).insertBefore('div.start-bar div.right.menu');
      }
      // if there is a method in the slugFunctions by this slug name.. run it.
      if ($(this).data('slug') != null && typeof slugFunctions[$(this).data('slug')] === 'function') {
        slugFunctions[$(this).data('slug')]();
      }
    });

    // Now iterate through out active task bar items and make sure the window still exists
    // If the window is removed, destroy the task bar item or remove active if it's static.
    $('div.start-bar a.item.active').each(function() {
      if (!$('div.window[data-slug='+$(this).data('slug')+']').length) {
        if ($(this).hasClass('static')) {
          $(this).removeClass('active');
        } else {
          $(this).remove();
        }
      }
    });
  };

  // @TODO if someone clicks BACK after restoring a window it should go back to previous state of window?

  // @TODO Question mark top right should give you some information about the window you have opened.. that means
  // each window could have different or similar information based on what the information is.  Or defined by MD?

  // @TODO Be able to set minimum window width/height dynamically in the .md
  
  // @TODO handle small views so we are no longer a window system if we get too small (mobile etc..)

  // @TODO Save UI state in cookies so you can come back to it later on a fresh page load.

  // @TODO window switching to full screen windows makes sure it's the latest in the url.

  // Quick hacked to gether date time function for bottom right of start bar.
  var updateDateTime = function() {
    var dT = new Date();
    $dateTime = $('div.start-bar time');
    var h = dT.getHours();
    var ap = h >= 12 ? 'PM' : 'AM';
    h = h > 12 ? h-12 : h;
    var m = dT.getMinutes();
    m = m < 9 ? '0'+m : m;
    var month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    var day = dT.getDate();
    var year = dT.getFullYear();
    $dateTime.html(h+':'+m+' '+ap+"<br/>"+month[dT.getMonth()]+' '+day+', '+year);
    setTimeout(updateDateTime, 60000);
  };

  /*
   * Stuff to run once we are ready to..  This is the starting point of the page post load.
   */

  // Function that contains stuff we need to do in other events
  var updateDesktop = function() {
    // Figure out how big our desktop actually is.. it's not the css size.
    adjustDesktop();
    // Really maximize any maximized windows
    maximizeWindow($('div.window.maximized'));
  };
  // Fire it off once
  updateDesktop();
  // Start the clock
  updateDateTime();
  // Set those start bar links as active or create the entry if there isn't one.
  updateStartbarLinks();
  // Init FB Comments again... I hate that I have to do this.
  if (typeof FB != "undefined") { FB.XFBML.parse(); }

  // Catch window resize
  $(window).resize(function(){
    updateDesktop();
  });

  /*
   * Clickable Events that must be live events .off'd then .on'd to avoid turbolink snafu's
   */

  // a.item clicks -- pull it in via json if we can, or if active and hiddenthen just unhide, or minimized/maximize..etc..
  $(document).off('click', 'a:not(.lightbox)').on('click', 'a:not(.lightbox)', function() {
    // if this item has the follow class, then fire the anchor off just like normal.
    // Otherwise we are going to try to json first, then if that fails.. add the class and fire the event.
    if (!$(this).hasClass('follow')) {
      // Prevent event
      event.preventDefault();

      // Define our $window
      var $window = $('div.window[data-slug='+$(this).data('slug')+']');
      // Check to see if we have a window with this slug
      if ($window.length) {
        // Bring the window to front
        bringToFront($window);
        // If the item is active and hidden, then show it
        if ($window.hasClass('hidden')) {
          $window.removeClass('hidden');
        // If the item is active and maximized, then restore it
        } else if ($window.hasClass('maximized')) {
          restoreWindow($window);
        // If the item is active and restored, then maximize it
        } else {
          maximizeWindow($window);
        }
      // Okay we don't see that window.. so go get it via ajax.
      } else {
        // If we don't have an href, then lets quietly go away
        var url = $(this).attr('href');
        if (typeof url == 'undefined') return;
        $.ajax({
          dataType: "json",
          url: url,
          success: function(data) {
            // Success!  Now create our new window object
            var obj = $(data.html).appendTo('div.desktop');
            // Make sure it's both draggable and resizable
            $(obj).draggable(draggableWindowArguments);
            $(obj).resizable(resizableWindowArguments);
            // Set the window as maximized because we start them all that way.
            maximizeWindow($(obj));
            // Update our start bar
            updateStartbarLinks();
          },
          fail: function(data) {
            // We have failed.. Go to the hard location.
            window.location = $(event.target).attr('href');
          }
        });
      }

    }
  });

  // RESTORE BUTTON at top right of window
  $(document).off('click', 'button.restore.window').on('click', 'button.restore.window', function() {
    var $window = $(this).parents('div.ui.window');
    restoreWindow($window);
  });

  // RESTORE BUTTON at top right of window
  $(document).off('click', 'button.maximize.window').on('click', 'button.maximize.window', function () {
    var $window = $(this).parents('div.ui.window');
    setWindowLocationData($window);
    maximizeWindow($window);
  });

  // MINIMIZE BUTTON at top right of window
  $(document).off('click', 'button.minimize.window').on('click', 'button.minimize.window', function() {
    var $window = $(this).parents('div.ui.window');
    $window.addClass('hidden');
  });

  // CLOSE BUTTON at top right of window
  $(document).off('click', 'button.close.window').on('click', 'button.close.window', function() {
    var $window = $(this).parents('div.ui.window');
    // Destroy window from dom
    $window.remove();
    // Nowupdate the start bar to remove or whatever the task
    updateStartbarLinks();
    // Pop State from History
    history.pushState({}, "", "/");
  });

  // AUDIO PLAY BUTTON at top right of window
  $(document).off('click', 'button.window.audio.play').on('click', 'button.window.audio.play', function() {
    // Check to see if the audio element is already created
    var $window = $(this).parents('div.ui.window');
    var slug = $window.data('slug');
    var $audioElement = $('audio[data-slug='+slug+']');
    // If no element, create it
    if (!$audioElement.length) {
      var $audioElement = $('<audio class="hidden" src="'+$(this).data('audio')+'" data-slug="'+slug+'"></audio>').appendTo('div.desktop');
    }
    // Play the audio
    $audioElement.trigger('play');
    // Hide the play button and show the pause button
    $(this).addClass('hidden');
    $(this).siblings('.pause').removeClass('hidden');
    
    // @TODO handle auto play
  });

  // AUDIO PAUSE BUTTON
  $(document).off('click', 'button.window.audio.pause').on('click', 'button.window.audio.pause', function() {
    // Find our audio element
    var slug = $(this).parents('div.ui.window').data('slug');
    var $audio = $('audio[data-slug='+slug+']');
    // If we found it, pause it
    if ($audio.length) {
      $audio.trigger('pause');
      // swap the icons back
      $(this).addClass('hidden');
      $(this).siblings('.play').removeClass('hidden');
    }
  });

  // WINDOW CLICK bring it to focus
  $(document).off('click', '.window').on('click', '.window', function() {
    bringToFront($(this));
  });

  // WINDOW HEADER DOUBLE CLICK, maximize/minimize
  $(document).off('dblclick', '.headbar').on('dblclick', '.headbar', function() {
    $window = $(this).parents('div.ui.window');
    if ($window.hasClass('maximized')) {
      restoreWindow($window);
    } else {
      maximizeWindow($window);
    }
  });


  /* STOCK Charting stuff.. */ //@TODO MOVE THIS TO IT"S OWN LOCATION...

  // Only try to draw the chart if there is a chart...
  slugFunctions['stocks'] = function() {
    if ($('#chart'.length)) {
      // https://developers.google.com/chart/interactive/docs/gallery/candlestickchart#data-format
      function drawChart() {
        // Setup our data
        var data = new google.visualization.DataTable();
        data.addColumn('number', 'X');
        data.addColumn('number', 'Dogs');

        data.addRows([
          [0, 0],   [1, 10],  [2, 23],  [3, 17],  [4, 18],  [5, 9],
          [6, 11],  [7, 27],  [8, 33],  [9, 40],  [10, 32], [11, 35],
          [12, 30], [13, 40], [14, 42], [15, 47], [16, 44], [17, 48],
          [18, 52], [19, 54], [20, 42], [21, 55], [22, 56], [23, 57],
          [24, 60], [25, 50], [26, 52], [27, 51], [28, 49], [29, 53],
          [30, 55], [31, 60], [32, 61], [33, 59], [34, 62], [35, 65],
          [36, 62], [37, 58], [38, 55], [39, 61], [40, 64], [41, 65],
          [42, 63], [43, 66], [44, 67], [45, 69], [46, 69], [47, 70],
          [48, 72], [49, 68], [50, 66], [51, 65], [52, 67], [53, 70],
          [54, 71], [55, 72], [56, 73], [57, 75], [58, 70], [59, 68],
          [60, 64], [61, 60], [62, 65], [63, 67], [64, 68], [65, 69],
          [66, 70], [67, 72], [68, 75], [69, 80]
        ]);

        var options = {
          hAxis: {
            title: 'Time'
          },
          vAxis: {
            title: 'Popularity'
          }
        };

        if ($('#chart').length) {
          var chart = new google.visualization.LineChart(document.getElementById('chart'));
          chart.draw(data, options);
        }

      }
      // Now init and draw that chart
      google.charts.load('current', {packages: ['corechart', 'line']});
      google.charts.setOnLoadCallback(drawChart);
    }
  }

});
