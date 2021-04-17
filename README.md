
Required:

1. Install ImageMagick
```
brew install ImageMagick
```
2. Install figaro
```
bundle exec figaro install
```

3. Add the following env vars, creating a new access key from Amazon AWS IAM for the blog's dev user:

```
# config/application.yml
development:
 S3_BUCKET_NAME:
 AWS_ACCESS_KEY_ID:
 AWS_SECRET_ACCESS_KEY:

production:
 S3_BUCKET_NAME:
 AWS_ACCESS_KEY_ID:
 AWS_SECRET_ACCESS_KEY:
```

When returning after a long time or on a new system, some typical issues:
1. Reinstalling ruby `rvm install ruby-3`
2. `brew install postgresql` to debug `pg` gem issues
3. Download the pgadmin gui and get the db login+passwords sorted locally

```
rake db:create
rake db:migrate
rake db:seed      // if you want sample data locally
rails s         
```

When updating gems, well... good luck.

To deploy once ready:

```
heroku login  // just once, obviously
git remote add heroku https://git.heroku.com/eriktrautman.git
git push heroku master
```
