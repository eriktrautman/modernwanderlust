modernwanderlust
================

Erik's Blog
Slideshow: http://paulmason.name/item/simple-jquery-carousel-slider-tutorial
Slideshow2: http://coding.smashingmagazine.com/2011/06/16/five-useful-interactive-css-jquery-techniques-deconstruted/

* Home page highlighting edu focus and photography

Unnecessarily nit-picky fixes and tweaks:
* error handling for Post finds
* change from :id to a more semantic name for redirects param
* Add disqus for commenting
* Add basic test coverage
* Add an overflow-scroll to pre elements

XXX Make typography consistent and logical! (h1/h2/h3 in posts...)
XXX About Page: I can usually be found hiking biking geeking or trying out new things or something like that
NOPE Put titlebar above nav NOPE
XXX Widen out the blog and fix the typography issues
XXX Fix width issues for about pages
XXX H4 tags need to be weight 500
XXX Title sucks.  Fix it.
XXX add flash close button javascript function
XXX Add a "sort" query string scope so, for instance, I can ask for the moto trip posts but in chron order.
XXX redirects from Modernwanderlust.com
XXX a sitemap for easy SEO indexing
NOPE photo uploader directly to the proper S3 bucket (paperclip or carrierwave gem and/or dropzone.js http://www.dropzonejs.com/)
XXX Build icons for next / prev
XXX Build Archive page with tags and chronology
XXX update about page
XXX Make sure there's an OPTION to update the slug if title changes and it defaults to false (warn how it messes with linkins!!!)
XXX Also fix descender cutoff in <pre> tags
XXX Make <p> tags inside lists not explode the font size... go to rems?  Anything that's potentially nested infinitely cannot be relative!!!
XXX Fix BG color to off white
XXX Make <pre> tags work and not overlap with <code> tags! (follow TOP lead... spacings, font color, the works)
XXX Make <em> tags work!
Roadmap:
XXX Posts
XXX Post creation interface
XXX Post display
XXX Static pages
XXX Add categories/tags
XXX Add pagination
XXX Add devise user auth
  XXX Have the admin bar only appear if logged in once devise is installed
XXX Build title slugs (uniques only!)
  XXX use friendly_id gem for slugging
XXX Add markdown rendering engine
  XXX new column -- md? T/F to decide if rendered
  XXX if rendered, display the post content as rendered
XXX Add GA tracking (haven't needed to fix turbolinks yet)
XXX Heroku Add-ons (newrelic, pgbackups)
Redesign:
  XXX Visual Heirarchy
  XXX Remove Bootstrap
  XXX Fix dates
  XXX Have previews for posts on index page
  XXX Contact Page
  XXX About Page
  XXX Typography
  XXX Hide edit/new buttons better when I'm logged in.
  XXX Fix flash now that bootstrap isn't there.
Refactor:
  XXX remove puts'
  XXX clean up timestamps on _post partials
  XXX fix wrap of pagination
  XXX FIX BLOODY ARCHIVES ORDERING!!! -- fixed by ignoring


















