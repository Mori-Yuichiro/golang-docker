FROM golang:1.18 AS base
WORKDIR /base
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main /base/main.go

# airのインストールに合わせてGolangのバージョンも変更
FROM golang:1.22 AS dev
WORKDIR /app
COPY --from=base /base .
RUN go install github.com/air-verse/air@latest
CMD [ "air" ]

# production
FROM alpine:latest AS production
WORKDIR /app
COPY --from=base /base/main .
COPY .env .
EXPOSE 8080
CMD ["/app/main"]