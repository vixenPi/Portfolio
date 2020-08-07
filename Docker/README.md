# Docker
Requirements:
- Install [Docker](https://docs.docker.com/get-docker/)
- Generate htpasswd file before running image: see Generate Log-in Credentials


## Generate Log-in Credentials
[How to create a log-in](https://www.hostwinds.com/guide/create-use-htpasswd/)

Instructions for adding log-ins to docker. Run in local directory and replace \<username> with desired username.

```
docker run --rm -it --entrypoint /usr/local/apache2/bin/htpasswd -v $PWD:/tmp httpd:latest -c /tmp/htpasswd <username>
```
Input and confirm password

## Run on Local Host

```
VERSION=$(curl --silent https://registry.hub.docker.com/v1/repositories/"vixenpi/secret-website"/tags | jq --raw-output '.[].name' | tail -n 1)
echo "Found version ${VERSION}"
docker run --name "secret-website" -p 80:80 -d --restart always vixenpi/secret-website:${VERSION}
```
will be running on localhost:8080


```
docker build --tag vixenpi/secret-website:<VERSION> .
docker push docker push vixenpi/secret-website:<VERSION>
```
