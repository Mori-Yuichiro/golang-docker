# development
FROM golang:1.18 AS builder
WORKDIR /build
COPY go.mod go.sum ./
RUN apt update &&\
    apt install git &&\
    go get github.com/air-verse/air@latest && \
    go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /build/main .

# production
FROM alpine:latest AS production
WORKDIR /app
COPY --from=builder /build/main .
COPY .env .
EXPOSE 8080
CMD [ "air" ]