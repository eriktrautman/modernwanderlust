modernwanderlust
================

Erik's Blog

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
Redesign
  Visual Heirarchy
  Typography
  Remove Bootstrap
  DO ITTTT
Refactor
  error handling for Post finds
  remove puts'
  clean up timestamps on _post partials
  fix wrap of pagination
  FIX BLOODY ARCHIVES ORDERING!!!
  change from :id to a more symantec name for redirects param
Add disqus for commenting

Style
  Make typography consistent and logical! (h1/h2/h3 in posts...)

Add basic test coverage

Additional fun stuff:
Home page highlighting edu focus and photography
Add design touches... ok, friggin redesign everything.
Add photo uploader directly to the proper S3 bucket (paperclip or carrierwave gem and/or dropzone.js http://www.dropzonejs.com/)


















