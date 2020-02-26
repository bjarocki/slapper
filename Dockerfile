FROM golang as build

ENV HOME /go/src/slapper
WORKDIR $HOME

ADD . $HOME

RUN \
  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
  dep ensure && \
  CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o slapper .

FROM scratch

COPY --from=build /go/src/slapper/slapper /

ENTRYPOINT ["/slapper"]
