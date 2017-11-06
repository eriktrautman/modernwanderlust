// Based on the example provided at http://coding.smashingmagazine.com/2011/06/16/five-useful-interactive-css-jquery-techniques-deconstruted/

// TODO: Build a continuous slide navigation as follows:
// we always have a current-slide, previous-slide, next-slide
// the NEXT operation animates the next and current slides left by the appropriate increment of left
// THEN switches classes on the all slides to their new positions, which won't affect the look of the slides since they should already be animated into position
// THEN removes any inline styles added by the animation
// the PREV operation does the opposite

// The nav still needs to record position!
// Initial nav needs to account for us starting on slide 2 (so we begin with a previous slide already in the left spot)
// NEXT and PREV operations advance like we are now -- it keeps track of actual position

// NO!! RETHINK! A long show still needs the ablity to click a nav button and zoom over to it... maybe?  unless you just quickly make it next ?  But that violates expectations....


$(function() {


  // *****************************
  // Define our functions
  // *****************************

  function changeSlide( newSlide ) {
    // cancel any timeout
    clearTimeout( slideTimeout );

    // make sure the newSlide value is not too low or high
    if ( newSlide > maxSlide ) newSlide = 0;
    else if ( newSlide < 0 ) newSlide = maxSlide;

    // Advance the Nav seeds
    changeNav( newSlide );

    // change the currSlide value
    currSlide = newSlide;

    // animate the slide reel
    $slideReel.animate({
        left : slideLeftPos( currSlide )
    }, 300, 'swing', function() {

      // hide / show the arrows depending on which frame it's on
      if ( currSlide == 0 ) $slidePrevNav.hide();
      else $slidePrevNav.show();

      if ( currSlide == maxSlide ) $slideNextNav.hide();
      else $slideNextNav.show();

      // set new timeout if active
      if ( activeSlideshow ) slideTimeout = setTimeout(nextSlide, slideTimeoutDuration);
    });
  }




  function changeNav( newSlide ){

    // remove the active item from the current nav
    $(navItems[currSlide]).html("&#9675;");

    // add the active ID to the new nav
    $(navItems[newSlide]).html("&#9679;");
  }



  function nextSlide() {
    changeSlide( currSlide + 1 );
  }


  // Get the right Left position for a given slide
  // Important when resizing
  function slideLeftPos( currSlide ) {
    return currSlide * -slideWidth;
  }


  // Needs to be triggered on browser resize
  function refreshWidths() {
    slideWidth = $slideshow.width();

    // ...pulling currSlide from global :/
    var left = slideLeftPos( currSlide );
    $slideReel.css("left", left);
  }



  // *****************************
  // define some variables / DOM references
  // *****************************

  var activeSlideshow = true;
  var currSlide = 0;
  var slideTimeout;
  var $slideshow = $('#slideshow');
  var $slideReel = $slideshow.find('#slideshow-reel');
  var maxSlide = $slideReel.children().length - 1;
  var $slidePrevNav = $slideshow.find('#slideshow-prev');
  var $slideNextNav = $slideshow.find('#slideshow-next');

  var $activeNavItem = $slideshow.find('#active-nav-item');
  var slideWidth = $('#slideshow').width();
  var slideTimeoutDuration = 5000;
  var navItems = $('.nav-item');
  var navWidth = navItems.width();




  // *****************************
  // Set listeners
  // *****************************

  window.addEventListener("resize",function(){
    refreshWidths();
  })

  // left arrow
  $slidePrevNav.click(function(ev) {
    ev.preventDefault();
    activeSlideshow = false;
    changeSlide( currSlide - 1 );
  });

  // right arrow
  $slideNextNav.click(function(ev) {
    ev.preventDefault();
    activeSlideshow = false;
    changeSlide( currSlide + 1 );
  });

    // main navigation
  $('#slideshow-nav a.nav-item').click(function(ev) {
    ev.preventDefault();
    activeSlideshow = false;
    changeSlide( $(this).index() );
  });



  // *****************************
  // Start the animation
  // *****************************

  slideTimeout = setTimeout(nextSlide, slideTimeoutDuration);
});
