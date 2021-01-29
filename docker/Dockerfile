FROM golang:1 AS builder
WORKDIR /srv
COPY . .
RUN go build -o app .

FROM scratch
COPY --from=builder /srv/app /app
ENTRYPOINT ["/app"]
CMD []
