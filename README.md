# heroku-buildpack-xmlsec

A buildpack for installing xmlsec1 on Heroku

## Usage

You may need to use this buildpack in conjunction with another; use the `heroku` cli 

    heroku buildpacks:add https://github.com/zenput/heroku-buildpack-xmlsec#1.2.37
    
or use the heroku admin website to add that buildpack.


Once xmlsec1 is installed via the buildpack you can run it with:

    heroku run xmlsec1

## Why Fork

### Security

#### Minimise Surface Area

This fork of a fork is because we didn't want to download a binary from someone
else's s3 bucket. Instead we're compiling our own binary and including it in the
buildpack.

#### Ability to quickly update

If there are any security vulnerabilities we should be in the position to deploy
an updated version without relying on third-parties.

### Ease of switching Heroku stacks

If we want to change the stack from `heroku:22-build` to a newer stack we can update our
`Dockerfile` to build from the correct image provided by Heroku.

## How it works

We are building the binary from source, this is slightly complicated because the
binary will be running inside of Heroku so if we build on a developer's machine
then there is no guarantee that any shared libraries the compiler links to will
be the same in Heroku. 

To get around this we are building in a Docker image that is based on the Heroku
`heroku:22-build` image, our image then downloads the source tarball for xmlsec1 and
compiles it then tar's the output to stdout. This is redirected into a file
outside of the docker container and into the local filesystem as `xmlsec.tar.gz`
this file is committed into the repo.

### But committing binaries into a repo is an anti-pattern

Yes but this means we don't need to have a CI pipeline pushing the tarball
somewhere like Amazon S3 and this isn't really a repository of code, we're not
really using it for source control. It's a git repo because that's what Heroku
wants custom buildpacks to be.

The downside of this is that it expects you to have Docker installed locally.


## How to update the binary
Install wget (brew install wget) if you don't have it installed already

```bash
$ export VERSION=1.2.37 # or whatever the version you want to build
$ git rm *.sig
$ make build
$ make release
$ git add xmlsec* README.md
$ git commit -m "update to version $VERSION"
$ git tag -a $VERSION -m "update to $VERSION"
$ git push --follow-tags
```
Then update your heroku application to use the buildpack with the tag you just
set e.g: blah

    https://github.com/zenput/heroku-buildpack-xmlsec#1.2.37
