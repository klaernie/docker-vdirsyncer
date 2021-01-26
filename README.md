# docker-vdirsyncer
A docker container which syncs your CalDAV/CardDAV calendars/addressbooks periodically.
This docker app uses [pimutils/vdirsyncer](https://vdirsyncer.pimutils.org/) to synchronize your CalDAV/CardDAV calendars/addressbooks between two servers.

## Getting started

1. create a vdirsyncer configuration file. See file [_config.example_](https://github.com/pimutils/vdirsyncer/blob/master/config.example) and [vdirsyncer docs](https://vdirsyncer.pimutils.org/)
2. choose one of the deployment methods

Be happy! The container will synchronize your calendars/addressbooks.

## Kubernetes example

I (klaernie) forked this repo to not only update it and improve it, but mainly to deploy it next to my [kubernetes hosted magic-mirror](https://github.com/bastilimbach/docker-MagicMirror/tree/master/doc/examples/k8s/klaernie).

Hence you'll find my configuration in k8s-manifests.
Adjust the namespace to your liking, and refer to my docker-MagicMirror setup for all the missing pieces.

Some caveats: I tried to put the gmail token file into the config map, but then realized, that it needs to be updated regularly to keep the token alive.
So it MUST be stored in a writable location, else vdirsyncer will fail updating the token and hence not even discover the storage.

## docker-compose example
1. adapt docker-compose.yml to use your configuration file
2. start the container via: `docker-compose up -d`

```yaml
version: '3'
services:

  worker:
    image: kaergel/vdirsyncer
    volumes:
      - ./your_config_file:/home/vds/.config/vdirsyncer/config
    restart: always
```

## manual example

if you want to use this image for isolating on your local machine, here is the command I used to test it:
```sh
docker run --mount type=bind,src=$HOME/.config/vdirsyncer,target=/home/vds/.config/vdirsyncer --mount type=bind,src=$HOME/MagicMirror/modules/calendars,target=$HOME/MagicMirror/modules/calendars -ti ghcr.io/klaernie/vdirsyncer
```

please note, that I am deliberately using the same path inside and outside the container for the calendar storage, as my config refers to it by it's full path.
