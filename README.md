# Docker Build and Push Action on Github

GitHub can double as a basic CI/CD system, automatically building your Docker images and sending them directly to the Docker Registry, the best part is that part is the job is already done, however, sometimes the documentation is not as easy to follow, so here I show you a basic example of how you can configure the [Docker build and push action](https://github.com/docker/build-push-action) in your repository.

## What you need:

* A Github repository
* A working [Dockerfile](Dockerfile) in the root of your directory
* Your [softawre](hello.sh)

## Enabling the action

Github looks for actions enabled in in a repository in the [workflows](.github/workflows) directory, here I created this [docker.yml](.github/workflows/docker.yml) file:

```yaml
on: [push, pull_request]

name: Docker

jobs:
  docker:
    name: Build and push to registry
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - uses: docker/build-push-action@v1
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
          repository: sulfurf/hello-action
          tag_with_sha: true
          tag_with_ref: true
```

At line 1 I'm telling github to perform the current action every time there's a new commit in any branch or a pull request. The following lines are usual github action code, but at line ***10*** I'm requesting a checkout of the code to be performed, if you omit this step, the build/push action will fail with a very cryptic error.

Finally, at line 13 we can see the actual build and push configuration, you can find a description of the parameters in their [project page](https://github.com/docker/build-push-action).
