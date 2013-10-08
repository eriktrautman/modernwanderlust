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
Add GA tracking (fix rails turbolinks issues)
Add disqus for commenting
Heroku Add-ons
Refactor
  error handling for Post finds
  remove puts'
  clean up timestamps on _post partials
  fix wrap of pagination

Add basic test coverage

Additional fun stuff:
Home page highlighting edu focus and photography
Add design touches
Add photo uploader directly to the proper S3 bucket
