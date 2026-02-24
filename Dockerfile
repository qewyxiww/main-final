FROM golang:1.23-alpine AS build-stage

WORKDIR /app

COPY . .

RUN go mod init github.com/qewyxiww/main-final 2>/dev/null || true
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o tracker-app

FROM alpine:latest

WORKDIR /root/

COPY --from=build-stage /app/tracker-app .
COPY --from=build-stage /app/tracker.db .

RUN chmod +x tracker-app

CMD ["./tracker-app"]