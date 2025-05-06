FROM golang:1.24.3-alpine3.20 AS build

RUN apk update && apk add git && apk add curl

WORKDIR /go/src/github.com/planetlabs/draino
COPY . .

RUN go build -o /draino ./cmd/draino

FROM alpine:3.20

RUN apk update && apk add ca-certificates
RUN addgroup -S user && adduser -S user -G user
USER user
COPY --from=build /draino /draino
ENTRYPOINT [ "/draino" ]
