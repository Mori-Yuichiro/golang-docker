# development
# FROM golang:1.18 AS builder
# WORKDIR /build
# COPY go.mod go.sum ./
# RUN apt update &&\
#     apt install git &&\
#     go get github.com/air-verse/air@latest && \
#     go mod download
# COPY . .
# RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /build/main .

# # production
# FROM alpine:latest AS production
# WORKDIR /app
# COPY --from=builder /build/main .
# COPY .env .
# EXPOSE 8080
# CMD [ "air" ]
FROM golang:1.18 AS base
WORKDIR /base
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main /base/main.go

FROM golang:1.18 AS dev
WORKDIR /app
COPY --from=base /base .
RUN go get github.com/air-verse/air@latest
CMD [ "air" ]

# production
FROM alpine:latest AS production
WORKDIR /app
COPY --from=base /base/main .
COPY .env .
EXPOSE 8080
CMD ["/app/main"]