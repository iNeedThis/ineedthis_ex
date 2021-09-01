# ineedthis

## Getting started
On systems with `docker` and `docker-compose` installed, the process should be as simple as:

```
docker-compose build
docker-compose up -d
```

If you use `podman` and `podman-compose` instead, the process for constructing a rootless container is nearly identical:

```
podman-compose build
podman-compose up -d
```

Once the application has started, navigate to http://localhost:8080 and login with admin@example.com / trixieisbestpony
