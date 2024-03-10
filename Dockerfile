FROM golang:1.21.0 as builder
WORKDIR /app

ENV APP_NAME="automatic-succotash"

ADD . /app
RUN CGO_ENABLED=0 GOOS=linux go build -o /${APP_NAME}

FROM gcr.io/distroless/base-debian11
WORKDIR /

ENV APP_NAME="automatic-succotash"

COPY --from=builder /${APP_NAME} /${APP_NAME}
ENV PORT 8080
CMD ["/automatic-succotash"]
