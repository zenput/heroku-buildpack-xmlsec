# heroku-buildpack-xmlsec

A buildpack for installing xmlsec1 on Heroku
This fork is for Cedar14, as the original repo only supported standard Cedar (openssl version incompatibility)

## Usage

You may need to use this buildpack in conjunction with another;
Use heroku-buildpack-multi to build multiple buildpacks:

    heroku config:add BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-multi.git

Example .buildpacks file:

    https://github.com/strydercorp/heroku-buildpack-xmlsec.git
    https://github.com/heroku/heroku-buildpack-ruby.git

Once xmlsec1 is installed via the buildpack you can run it with:

    heroku run xmlsec1

