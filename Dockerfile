FROM golang:1.25.1

WORKDIR /app

COPY . .

RUN go mod init tracker || true
RUN go mod tidy

RUN go build -o tracker-app .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/tracker-app .
COPY --from=builder /app/tracker.db .

EXPOSE 8080

CMD ["./tracker-app"]