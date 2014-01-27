// Based on the example provided at http://coding.smashingmagazine.com/2011/06/16/five-useful-interactive-css-jquery-techniques-deconstruted/
$(function() {
  function changeSlide( newSlide ) {
    console.log("CHANGING SLIDE!! newSlide: "+newSlide+" !!!");
    // cancel any timeout
    clearTimeout( slideTimeout );
    
    // change the currSlide value
    currSlide = newSlide;
    
    // make sure the currSlide value is not too low or high
    if ( currSlide > maxSlide ) currSlide = 0;
    else if ( currSlide < 0 ) currSlide = maxSlide;
    
    console.log("CHANGING SLIDE!! newSlide: "+newSlide+" !!!");

    // animate the slide reel
    $slideReel.animate({
        left : currSlide * -slideWidth
    }, 400, 'swing', function() {
      // hide / show the arrows depending on which frame it's on
      if ( currSlide == 0 ) $slidePrevNav.hide();
      else $slidePrevNav.show();
      
      if ( currSlide == maxSlide ) $slideNextNav.hide();
      else $slideNextNav.show();
      
      // set new timeout if active
      if ( activeSlideshow ) slideTimeout = setTimeout(nextSlide, slideTimeoutDuration);
    });
    
    // animate the navigation indicator
    $activeNavItem.animate({
      left : currSlide * 150
    }, 400, 'swing');
  }
  
  function nextSlide() {
    changeSlide( currSlide + 1 );
  }
  
  // define some variables / DOM references
  var activeSlideshow = true,
  currSlide = 0,
  slideTimeout,
  $slideshow = $('#slideshow'),
  $slideReel = $slideshow.find('#slideshow-reel'),
  maxSlide = $slideReel.children().length - 1,
  $slidePrevNav = $slideshow.find('#slideshow-prev'),
  $slideNextNav = $slideshow.find('#slideshow-next');
  $activeNavItem = $slideshow.find('#active-nav-item');
  slideWidth = $('#slideshow').width();
  slideTimeoutDuration = 3000;
  
  // set navigation click events
  
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
  $slideshow.find('#slideshow-nav a.nav-item').click(function(ev) {
    ev.preventDefault();
    activeSlideshow = false;
    changeSlide( $(this).index() );
  });
  
  // start the animation
  slideTimeout = setTimeout(nextSlide, slideTimeoutDuration);
});