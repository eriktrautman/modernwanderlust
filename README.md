Erik Trautman's Personal Site
http://www.eriktrautman.com

Required:

* Install ImageMagick
* Install figaro
* Add the following env vars:

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
