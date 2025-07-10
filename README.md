# Hello World .NET DevOps Project

This project demonstrates a complete CI/CD pipeline for a minimal .NET 8 application using GitHub Actions and Docker.

## Project Structure

```
.
├── HelloWorldApp/            # .NET 8 console app
├── HelloWorldApp.Tests/      # xUnit test project
├── Dockerfile                # Multi-stage Dockerfile
├── docker-compose.yml        # docker-compose file
├── hello-world-job.yml       # K8S Job file
├── .github/workflows/        # GitHub Actions CI/CD workflow
└── README.md                 # This file
```

## Running the App Locally

```bash
dotnet run --project HelloWorldApp
```

Output:
```
Hello World
```

## Running Tests

```bash
dotnet test HelloWorldApp.Tests
```

## Build & Run with Docker

```bash
docker build -t inframous/hello-world:local .
docker run --rm inframous/hello-world:local
```

## Docker Compose

You can run the container using `docker-compose`:

```bash
docker-compose up
```

## Kubernetes (Job)
To run the container in a Kubernetes cluster, use the following manifest:

```bash
kubectl apply -f hello-world-job.yml
kubectl logs job/hello-world-job
```
This will run the container once, capture its output, and then complete.
The second line will show you the logs.


## CI/CD Pipeline

A GitHub Actions workflow is triggered on every push to the `main` branch. It performs the following:

- Runs code formatting check with `dotnet format`
- Restores dependencies and builds the .NET application
- Executes unit tests
- Publishes the app and uploads it as an artifact
- Extracts a semantic version from the latest Git tag (e.g. `v1.0.0`)
- Builds a Docker image and tags it with the version
- Scans the image for vulnerabilities using Trivy (fails on HIGH/CRITICAL)
- Pushes the Docker image to Docker Hub
- Runs the container and verifies the console output includes “Hello World”
- Prints the pushed version tag

### Status Badge


![CI/CD](https://github.com/inframous/sheekoon/actions/workflows/ci-cd.yml/badge.svg)


## Docker Hub

Docker image is available at:

```
docker pull inframous/hello-world:<tag>
```

Example:

```bash
docker pull inframous/hello-world:v1.0.0
docker run --rm inframous/hello-world:v1.0.0
```

## Run the Pipeline Locally (Optional)

Install [`act`](https://github.com/nektos/act) to run GitHub Actions locally.

```bash
act push
```

## Notes

- GitHub Secrets required: `DOCKERHUB_USER`, `DOCKERHUB_TOKEN`
- Make sure to tag commits (`git tag v1.0.0`) to update image versions

---
