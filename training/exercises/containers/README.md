# Containers — first hands-on exercise

## Goal

In roughly 20–25 minutes you will:

1. run an existing container image;
2. map a host port to the container;
3. inspect container lifecycle and logs;
4. build your first custom image from the included `Dockerfile`;
5. change the page, build a second image version and replace the running container;
6. see directly that changing a source file does not mutate an already-built image or an already-running container.

## Prerequisites

- Docker Desktop or another compatible Docker engine is running.
- `docker version` succeeds.
- Port `8080` is free on your machine.

## Part 1 — run an existing image

```bash
docker pull nginx:alpine

docker run --name web-base -p 8080:80 nginx:alpine
```

Open `http://localhost:8080`.

In another terminal inspect what is running:

```bash
docker ps
docker logs web-base
```

Think about the port mapping:

- `8080` is the port on your development machine;
- `80` is the port exposed by nginx inside the container.

Stop and remove only the container:

```bash
docker stop web-base
docker ps
docker ps -a
docker rm web-base
```

Notice that the `nginx:alpine` image is still available locally:

```bash
docker images
```

## Part 2 — build your first image

This folder already contains:

- `index.html` — the page served by nginx;
- `Dockerfile` — the instructions used to create the image.

Edit `index.html` and replace `YOUR_NAME` with your name.

Build version 1:

```bash
docker build -t ticket-lab:v1 .
```

Run it:

```bash
docker run --name ticket-lab -p 8080:80 ticket-lab:v1
```

Open `http://localhost:8080` again and inspect the local images/containers:

```bash
docker images
docker ps
```

## Part 3 — demonstrate image immutability

While `ticket-lab:v1` is still running, change the text in `index.html` and refresh the browser.

The running page should **not** change. The source file on your host is not the filesystem of the already-built image or the running container.

Build a new image version:

```bash
docker build -t ticket-lab:v2 .
```

Replace the running container:

```bash
docker stop ticket-lab
docker rm ticket-lab

docker run --name ticket-lab -p 8080:80 ticket-lab:v2
```

Refresh `http://localhost:8080`. You should now see the new content.

## Cleanup

```bash
docker stop ticket-lab
docker rm ticket-lab
```

Optional image cleanup:

```bash
docker rmi ticket-lab:v1 ticket-lab:v2
```

## Discussion

Be ready to explain:

- the difference between an **image** and a **container**;
- what `8080:80` means;
- why an immutable image is useful in CI/CD;
- why we build a new image rather than modifying a running production container.
