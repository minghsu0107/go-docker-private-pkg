# go-docker-private-pkg
This repository shows how to build a Golang Docker image if your Golang application imports a private package.
## Build Docker Image
```bash
export GIT_USER=<github-user>
export GIT_TOKEN=<github-personal-token>
docker build --build-arg GIT_USER=$GIT_USER --build-arg GIT_TOKEN=$GIT_TOKEN -t minghsu0107/go-private-pkg .
```
Run container:
```bash
docker run --rm -p 8080:8080 minghsu0107/go-private-pkg
```
Test server endpoint:
```bash
curl http://localhost:8080/ping
```
Expected response:
```
{"message":"hello world"}
```
## Local Development
`github.com/minghsu0107/go-private-hello` is a private repository for demonstration. The `GOPRIVATE` environment variable controls which modules the go command considers to be private (not available publicly) and should therefore not use the proxy or checksum database.
```bash
go env -w GOPRIVATE=github.com/minghsu0107/go-private-hello
export GIT_USER=<github-user>
export GIT_TOKEN=<github-personal-token>
git config --global url."https://$GIT_USER:$GIT_TOKEN@github.com".insteadOf "https://github.com"
```
Download dependencies:
```bash
go mod download
```