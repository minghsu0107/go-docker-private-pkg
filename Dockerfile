FROM golang:1.18 as build

WORKDIR /go/src/app

RUN go env -w GOPRIVATE=github.com/minghsu0107/go-private-hello
ARG GIT_USER
ARG GIT_TOKEN
ENV GIT_USER=$GIT_USER
ENV GIT_TOKEN=$GIT_TOKEN
RUN git config --global url."https://${GIT_USER}:${GIT_TOKEN}@github.com".insteadOf "https://github.com"

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o /go/bin/app main.go

FROM gcr.io/distroless/static-debian11

COPY --from=build /go/bin/app /app
CMD ["/app"]