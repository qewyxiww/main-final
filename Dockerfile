FROM golang:1.25.1

WORKDIR /app

COPY . .

RUN go get github.com/stretchr/testify
RUN go get modernc.org/sqlite

RUN go build -o tracker-app

RUN chmod +x tracker-app

CMD ["./tracker-app"]