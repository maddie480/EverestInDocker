# Everest in Docker

Headless Docker builds of [Everest, the Celeste mod loader](https://github.com/EverestAPI/Everest), intended for automated testing.

The built image is published on Docker Hub as `max480/everest`, with tags `stable`, `beta` and `dev`. Everest is installed in `/home/ubuntu/celeste`.

## Running the image directly

You can run Everest stable using:
```sh
docker run --rm max480/everest:stable
```

You can run Everest dev with a specific Mods folder using:
```sh
docker run --rm -v /path/to/mods/folder:/home/ubuntu/celeste/Mods max480/everest:dev
```

You can run Everest dev with verbose logging using:
```sh
docker run --rm max480/everest:dev --loglevel verbose
```

## Building an Everest image with a mod setup

**Hint:** if you want to download a mod setup quickly (for instance, Spring Collab and its dependencies), you can use https://maddie480.ovh/celeste/bundle-download?id=SomeModId (replace with the `everest.yaml` ID of the mod you want).

For instance, you can create your own image of Everest with [Spring Collab](https://maddie480.ovh/celeste/gb?id=SpringCollab2020) installed by creating a file named `Dockerfile` containing: 

```dockerfile
FROM max480/everest:dev

RUN cd /home/ubuntu/celeste/Mods \
    && curl -o mods.zip https://maddie480.ovh/celeste/bundle-download?id=SpringCollab2020 \
    && unzip mods.zip \
    && rm -v mods.zip
```

Then, open a command line, `cd` to the folder containing the Dockerfile and run:
```sh
docker build . -t everest-with-spring-collab
```

You can then run the image using:
```sh
docker run --rm everest-with-spring-collab
```

## Running Everest in GitHub Actions

Here is an example setup that runs Everest in GitHub Actions with [Spring Collab](https://maddie480.ovh/celeste/gb?id=SpringCollab2020) installed:
```yaml
name: Run Everest

on:
  workflow_dispatch: {}

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    container:
      image: max480/everest:dev
    steps:
      - name: Run the thing
        run: |
          cd /home/ubuntu/celeste/Mods
          curl -o mods.zip https://maddie480.ovh/celeste/bundle-download?id=SpringCollab2020
          unzip mods.zip
          rm mods.zip
          cd ..
          ./Celeste
```

Note that **this action fails**, because the game doesn't do anything once it's started up, until the job times out (hence the 5-minute limit set in the example). You need to install a code mod to the setup that makes the game run some tests, then exit with the appropriate exit code to end the action.
