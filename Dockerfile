FROM heroku/cedar:14

ARG VERSION

RUN gpg --keyserver keyserver.ubuntu.com --recv-key 9E1D829E && \
    wget https://www.aleksey.com/xmlsec/download/xmlsec1-${VERSION}.sig && \
    wget https://www.aleksey.com/xmlsec/download/xmlsec1-${VERSION}.tar.gz && \
    gpg --verify xmlsec1-${VERSION}.sig xmlsec1-${VERSION}.tar.gz && \
    tar xvf xmlsec1-${VERSION}.tar.gz

WORKDIR ./xmlsec1-${VERSION}
RUN ./configure --enable-static --enable-static-linking && make -j `nproc`
CMD cat ./apps/xmlsec1
