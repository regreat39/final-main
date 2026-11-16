FROM golang:1.26 AS build

WORKDIR /app

COPY go.mod go.sum

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main .

FROM alpine:3

WORKDIR /app

COPY --from=build /main /main

COPY tracker.db .

CMD ["/main"]