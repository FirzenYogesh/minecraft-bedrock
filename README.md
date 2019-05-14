# Minecraft Bedrock Server for Docker

A Docker container to run Minecraft Bedrock Server.

## Prerequisites

- Docker

## Instructions

This docker can be executed easily

1. Pull the docker image:

``` Docker
docker pull firzenyogesh/minecraft-bedrock
```

2. Start the container:

``` Docker
docker run --network=host firzenyogesh/minecraft-bedrock
```

### Advanced Settings

The above method is to start the server quick. There is a chance that you will lose your world's progress, if this container is updated (*eg. new server version*). To overcome that we use volume. We mount on a path that is outside the container

``` Docker
docker run -v "/minecraft:/srv/minecraft" --network=host firzenyogesh/minecraft-bedrock
```

**Assuming `/minecraft` is the path to mount in your machine. Change the path to your preference**

- This will create the folders `worlds`, `resource_packs`, `behavior_packs`, `premium_cache`, `world_templates`, and `properties_for_worlds` in the path `/minecraft`

- This will create the files `invalid_known_packs.json`, `valid_known_packs.json` in the path `/minecraft`

These *files and folders* are generated to easliy import your existing ***mods*** and ***worlds*** to the container.

It is **recommended** to run the above mentioned command ***once***, before importing your existing ***worlds*** and ***mods***.

You can however do that without running the command, provided you have copied the `resource_packs`, `behavior_packs` and `worlds` folders from your existing server to the path `/minecraft`. If this is not done the server won't start. So make sure that atleast `resource_packs` and `behavior_packs` are there in the `/minecraft` path.

### Bonus Note

- If you want your world to have different name, start the container like this:

``` Docker
docker run -e WORLD=worldname --network=host firzenyogesh/minecraft-bedrock
```

- If you want run on different port, start the container like this:

``` Docker
docker run -e PORT=19132 -e PORTv6=19133 --network=host firzenyogesh/minecraft-bedrock
```