/**
 * jQuery Lightbox v1.5
 * by Jason "Palamedes" Ellis <palamedes[at]rocketmail.com>
 * Requires jQuery 1.3 or later
 *
 * This javascript module is designed to turn any link with the correct attribute
 * into a lightbox link.   Meaning, an anchor with rel='lightbox' will display that
 * image in a lightbox like format.  All CSS and Javascript is within this file with
 * the exception of jQuery.
 *
 * I specifically am writing this to work with my Wordpress blog without having
 * to create a special plugin to do the work for me.  Just add the attribute to the link
 * and tada.. lightbox.
 *
 * Also this is a good way for me to learn a little about jquery .. feel free to comment
 * to me about what you think I have done right or wrong.. feedback is always welcome
 * Note: I first wrote this back on 2007 and still use it to this day, but comments are
 * no longer required as I know how bad it is.. hah
 *
 * Usage:
 * It will automatically convert all anchors with rel='lighbox' to lightboxes upon page load,
 * or you may call .lightbox() on a jquery object in order to convert any children..
 *
 * Jason
 */

$(document).ready(function() {

  $(".lightbox").on('click', function() {
    // localize this
    var dis = $(this);
    // get the href
    var source = dis.attr('href');
    // make sure its an image
    var re = /^.*?(.gif|.jpg|.png)$/i;
    var isImage = re.exec(source);
    if (!isImage) {
      // Not an image, don't lightbox it
      return true;
    }
    // Push the state into the browser so we know to open it if someone links to this directly
    if (history.pushState != undefined && window.location.hash == "") {
      history.pushState({}, document.title, window.location.href += ('#lightbox-' + $(this).index("a[rel='lightbox']")));
    }

    // okay now load the real image!
    newImage = new Image();
    newImage.id = 'lightboxImage';
    newImage.src = source;

    // Deal with the different browsers
    var position = {
      scrollTop : function () {
        return  window.pageYOffset ||
          document.documentElement && document.documentElement.scrollTop ||
          document.body.scrollTop;
      },
      innerHeight : function () {
        return	window.innerHeight ||
          document.documentElement && document.documentElement.clientHeight ||
          document.body.clientHeight;
      },
      innerWidth : function () {
        return	window.innerWidth ||
          document.documentElement && document.documentElement.clientWidth ||
          document.body.clientWidth;
      }
    }

    // Get the body overflow state
    var overflowState = $('body').css('overflow');

    // Hide the scroll bars on the right
    $('body').css({overflow:"hidden"});

    // Create the lightboxShade element and append to body
    $('<div id="lightboxShade"></div>').appendTo('body');
    // Style the element
    var lightboxShadeCSS = {
      'position' : 'absolute',
      'top' : position.scrollTop() + 'px',
      'left' : '0px',
      'bottom' : 'auto',
      'width' : '100%',
      'height' : position.innerHeight() + 'px',
      'background' : 'black',
      'opacity' : '0.8',
      'display' : 'none',
      'z-index' : '10000',
      'text-align' : 'center',
      'margin' : '0',
      'padding' : '0'
    };
    // Apply the styles
    $('#lightboxShade').css(lightboxShadeCSS);
    // Create the center box
    $('<div id="lightbox"><img id="lightboxImage"src="/images/loading.gif" /><div class="closeMsg">Click anywhere to close</div></div>').appendTo('body');

    var disClick = function() {
      // Set history back
      if (history.pushState != undefined) {
        history.pushState({}, document.title, window.location.href.replace(window.location.hash,''));
      }
      // animate the destruction of the lightbox itself
      $('#lightbox').animate({
        width: '0px',
        height: '0px',
        top: (position.scrollTop() + (position.innerHeight() / 2)) + "px",
        marginLeft : '0px',
        opacity: '0'
      }, 300);
      // fade out the lightbox shade
      $('#lightboxShade').fadeOut(500, function(){
        // make the scroll bars visible again
        $('body').css({'overflow':overflowState});
        // destroy the elements
        $('#lightbox').remove();
        $('#lightboxShade').remove();
      });
    }

    $('#lightboxImage').click(disClick);
    $('#lightboxShade').click(disClick);

    // style the element
    var lightboxCSS = {
      'width' : '1px',
      'height' : '1px',
      'background' : 'white',
      'opacity' : '1',
      'border' : '2px solid black',
      'top' : (position.scrollTop() + (position.innerHeight() / 2)) + 'px',
      'left' : '50%',
      'position' : 'absolute',
      'z-index' : '10001',
      'text-align' : 'center'
    };
    // apply the styles
    $('#lightbox').css(lightboxCSS);

    // style the close text
    var lightboxCloseMsgCSS = {
      'font-family' : 'verdana',
      'font-size' : '9px',
      'color' : 'white',
      'position' : 'absolute',
      'right' : '0px',
      'bottom' : '-11px'
    };
    // apply styles to close text
    $('#lightbox div.closeMsg').css(lightboxCloseMsgCSS);

    // fade the lightbox in -- shade faster!
    $('#lightboxShade').fadeIn(300);

    // Now animate from 1x1 to a loading box
    var initialHeight = 80;
    var initialWidth = 100;
    $('#lightbox').animate({
      'width' : initialWidth + 'px',
      'height' : initialHeight + 'px',
      'paddingTop' : '20px',
      'top' : position.scrollTop() + ((position.innerHeight() / 2) - (initialHeight / 2)) + 'px',
      'marginLeft' : '-' + (initialWidth/2) + 'px'
    }, 200);


    // Test to see if the image is loaded, if it is show it!
    imageLoaded = function() {
      if (newImage.height > 0) {

        imageHeight = newImage.height;
        imageWidth = newImage.width;

        // Is the image bigger than our screen?  Scale it down if it is
        if (imageHeight > imageWidth) {
          if (imageHeight > position.innerHeight()) {
            var percentage = ((position.innerHeight()-20) / imageHeight);
            imageWidth = imageWidth * percentage;
            imageHeight = imageHeight * percentage;
          }
          if (imageWidth > position.innerWidth()) {
            var newPercentage = ((position.innerWidth()-20) / imageWidth);
            imageWidth = imageWidth * newPercentage;
            imageHeight = imageHeight * newPercentage;
          }
        } else {
          if (imageWidth > position.innerWidth()) {
            var percentage = ((position.innerWidth()-20) / imageWidth);
            imageWidth = imageWidth * percentage;
            imageHeight = imageHeight * percentage;
          }
          if (imageHeight > position.innerHeight()) {
            var newPercentage = ((position.innerHeight()-20) / imageHeight);
            imageWidth = imageWidth * newPercentage;
            imageHeight = imageHeight * newPercentage;
          }
        }
        $('#lightboxImage').css({"width": imageWidth + "px", "height": imageHeight  + "px"});

        $('#lightboxImage').css("display","none");
        // Resize the white to fit the image!
        $('#lightbox').animate({
          'width' : imageWidth + 'px',
          'height' : imageHeight + 'px',
          'paddingTop' : '0px',
          'top' : position.scrollTop() + ((position.innerHeight() / 2) - (imageHeight / 2)) + 'px',
          'marginLeft' : '-' + (imageWidth/2) + 'px'
        }, 250, function() {
          $('#lightboxImage').attr("src",newImage.src);
          $('#lightboxImage').css("display","block");
        });

      } else {
        // @TODO What if it never finds the image? Need Max Revs here..
        setTimeout("imageLoaded()", 200);
      }
    }

    // Okay now start waiting for the image to load..
    setTimeout("imageLoaded()", 200);

    return false;

  });

  var hashMatch = location.hash.match(/#lightbox-(.*)/);
  if (hashMatch != null) {
    $("a[rel='lightbox']")[hashMatch[1]].click();
  }

});

/* Changelog

 1.5
 * Added push states to the light box so the navigation bar reflects where we are.
 * Also added the ability to automatically open that lightbox when you go to that pasted link.

 1.3 to 1.4
 * changed the z-index from 100 to 10000 in order to combat some sites that have higher z-indexes going on.
 * removed the closing animation infavor of a fade out
 * clicking the shade or the box will close the box now
 * added text to the bottom right that says to click anywhere.
 * I also corrected the key:value pairs to meet spec

 */
