# Docker
Requirements:
- Install [Docker](https://docs.docker.com/get-docker/)
- Generate htpasswd file before building or running image


## Generate Log-in Credentials
[How to create a log-in credentials](https://www.hostwinds.com/guide/create-use-htpasswd/)

Instructions for adding log-ins to site. Run first command in local directory and replace \<username> with desired username to create first credential. Use Second command to create subsequent credentials. Input and confirm password.

First Credential

```
docker run --rm -it --entrypoint /usr/local/apache2/bin/htpasswd -v $PWD:/tmp httpd:latest -c /tmp/htpasswd <username>
```
Additional Credential

```
docker run --rm -it --entrypoint /usr/local/apache2/bin/htpasswd -v $PWD:/tmp httpd:latest /tmp/htpasswd  <username>
```


## Edit on Local Host
1. Download Repository
2. Create credentials   
3. Run in local directory
```
docker-compose up
```

Will be running on localhost:8080

Edit html files, save, and reload localhost:8080

Changes will appear

## Pull Latest Image

```
VERSION=$(curl --silent https://registry.hub.docker.com/v1/repositories/"vixenpi/secret-website"/tags | jq --raw-output '.[].name' | tail -n 1)
echo "Found version ${VERSION}"
docker run --name "secret-website" -p 80:80 -d --restart always vixenpi/secret-website:${VERSION}
```


## Create and Push Newer Image
```
VERSION=$(curl --silent https://registry.hub.docker.com/v1/repositories/"vixenpi/secret-website"/tags | jq --raw-output '.[].name' | tail -n 1)
echo "Found version ${VERSION}"
docker build --tag vixenpi/secret-website:${VERSION} .
docker push docker push vixenpi/secret-website:${VERSION}
```
