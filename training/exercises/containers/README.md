# Containers — hands-on exercise

## Goal

In roughly 40–50 minutes you will:

1. run an existing container image;
2. map a host port to the container;
3. inspect container lifecycle and logs;
4. serve a local `index.html` through a bind-mounted volume;
5. build your first custom image from the included `Dockerfile`;
6. create a simple Docker Compose app with a JavaScript frontend and a small backend API;
7. tag your image with your name and push it to a shared registry provided by the trainer.

## Prerequisites

- Docker Desktop or another compatible Docker engine is running.
- `docker version` succeeds.
- `docker compose version` succeeds.
- Ports `8080`, `8081` and `3001` are free on your machine.
- The trainer will provide registry URL and credentials for the push step.

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

## Part 2 — serve a local file through a bind mount

In this part nginx still comes from the public `nginx:alpine` image, but the page is read directly from your local working folder.

From this directory run one of the following commands.

Bash / Git Bash / WSL:

```bash
docker run --name web-volume -p 8080:80 \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html:ro" \
  nginx:alpine
```

PowerShell:

```powershell
docker run --name web-volume -p 8080:80 `
  -v "${PWD}/index.html:/usr/share/nginx/html/index.html:ro" `
  nginx:alpine
```

Open `http://localhost:8080`.

Now edit `index.html` and refresh the browser. The page changes without rebuilding an image because nginx reads the file from the mounted host path.

Cleanup:

```bash
docker stop web-volume
docker rm web-volume
```

## Part 3 — build your first image

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

## Part 4 — demonstrate image immutability

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

Cleanup before the next part:

```bash
docker stop ticket-lab
docker rm ticket-lab
```

## Part 5 — run a small frontend + backend with Docker Compose

Go to the Compose sample:

```bash
cd compose-app
```

Start both services:

```bash
docker compose up --build
```

Open `http://localhost:8081`.

What happens:

- the frontend is a small JavaScript page served by nginx;
- the frontend calls the backend API at `http://localhost:3001/api/tickets`;
- the backend returns sample ticket data;
- Compose creates a private network where services can run together, while selected ports are exposed to your host.

Inspect the services:

```bash
docker compose ps
docker compose logs backend
docker compose logs frontend
```

Stop and remove the Compose stack:

```bash
docker compose down
```

Return to the container exercise folder:

```bash
cd ..
```

## Part 6 — tag and push your image

The trainer will provide registry URL and credentials. Do not commit those credentials to the repository.

Set your variables. Use lowercase ASCII for `YOUR_NAME`, for example `marek-lani`.

Bash / Git Bash / WSL:

```bash
REGISTRY_HOST="<TRAINER_PROVIDED_REGISTRY>"
YOUR_NAME="<your-name>"
```

PowerShell:

```powershell
$REGISTRY_HOST = "<TRAINER_PROVIDED_REGISTRY>"
$YOUR_NAME = "<your-name>"
```

Login:

```bash
docker login <TRAINER_PROVIDED_REGISTRY>
```

Tag and push:

```bash
docker tag ticket-lab:v2 <TRAINER_PROVIDED_REGISTRY>/ticket-lab:<your-name>
docker push <TRAINER_PROVIDED_REGISTRY>/ticket-lab:<your-name>
```

Example shape of the final tag:

```text
registry.example.com/ticket-lab:marek-lani
```

Verify locally:

```bash
docker images | grep ticket-lab
```

## Final cleanup

```bash
docker rmi ticket-lab:v1 ticket-lab:v2
```

Compose cleanup if it is still running:

```bash
cd compose-app
docker compose down
```

## Discussion

Be ready to explain:

- the difference between an **image** and a **container**;
- what `8080:80` means;
- when a bind mount is useful during local development;
- why changing a mounted file is different from rebuilding an image;
- why Compose is easier than multiple long `docker run` commands;
- why we tag images before pushing them to a registry;
- why credentials and registry names are configuration, not source code.
