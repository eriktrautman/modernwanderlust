// Based on the example provided at http://coding.smashingmagazine.com/2011/06/16/five-useful-interactive-css-jquery-techniques-deconstruted/
$(function() {
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
    // OBSOLETE -- Not used in this slideshow!
    // $activeNavItem.animate({
    //   left : currSlide * 150
    // }, 400, 'swing');
  }

  function changeNav( newSlide ){

    console.log("CURR is " + currSlide);
    console.log("ENW is " + newSlide);

    // remove the active item from the current nav
    $(navItems[currSlide]).html("&#9675;");

    // change current slide
    // currSlide = newSlide;

    // add the active ID to the new nav
    $(navItems[newSlide]).html("&#9679;");
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
  navItems = $('.nav-item');
  navWidth = navItems.width();
  
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