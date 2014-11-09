Build and install xmlsec1 for use with Heroku

You may need to use this buildpack in conjunction with another;
Use heroku-buildpack-multi to build multiple buildpacks:

    heroku config:add BUILDPACK_URL=https://github.com/even/heroku-buildpack-multi.git

Example .buildpacks file:

    https://github.com/evenco/heroku-buildpack-xmlsec.git
    https://github.com/evenco/heroku-buildpack-go.git

Once xmlsec1 is installed via the buildpack:

    heroku run xmlsec1

