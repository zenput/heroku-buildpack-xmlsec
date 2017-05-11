NS = uktrade
NAME = xmlsec1
INSTANCE = default
VERSION ?= 1.2.24

.PHONY: build shell rm build release rmi

build:
	docker build -t $(NS)/$(NAME):$(VERSION) --build-arg VERSION=${VERSION} .

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -i -t $(NS)/$(NAME):$(VERSION) /bin/bash

release:
	docker run --rm --name $(NAME)-$(INSTANCE) $(NS)/$(NAME):$(VERSION) > ./xmlsec.tar.gz

rm:
	docker rm $(NAME)-$(INSTANCE)

rmi:
	docker rmi $(NS)/$(NAME)

clean:
	rm ./bin/xmlsec1

default: build
