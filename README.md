## Notes
 - Dockerfile minimize image size with multi stage build
 - nginx.conf and trailing slashes
 - use containers explicitly in nginx.conf instead of localhost

## Usage

Build and start all containers (will attempt to delete intermediate build
containers and images):
```bash
make build # build images
make clean # remove intermediate images from build
make up
```

Check containers are up by visiting:
```bash
localhost:9000/ping # nginx
localhost:9001/ping # auth
localhost:9002/ping # user

# should be able to access both services via nginx gateway
localhost:9000/auth/ping
localhost:9000/users/ping
```

Stop all containers:
```bash
make down
```
