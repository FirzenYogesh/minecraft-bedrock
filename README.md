# Minecraft Bedrock Server for Docker

<!-- [![Build Status](https://travis-ci.org/firzenyogesh/minecraft-bedrock.svg?branch=master)](https://travis-ci.org/firzenyogesh/minecraft-bedrock)  -->
[![Docker Pulls](https://img.shields.io/docker/pulls/firzenyogesh/minecraft-bedrock.svg)](https://hub.docker.com/r/firzenyogesh/minecraft-bedrock/) 
[![Docker Layers](https://images.microbadger.com/badges/image/firzenyogesh/minecraft-bedrock.svg)](https://microbadger.com/images/firzenyogesh/minecraft-bedrock)
[![Docker Version](https://images.microbadger.com/badges/version/firzenyogesh/minecraft-bedrock.svg)](https://microbadger.com/images/firzenyogesh/minecraft-bedrock "Get your own version badge on microbadger.com")
[![Github Stars](https://img.shields.io/github/stars/firzenyogesh/minecraft-bedrock.svg?label=github%20%E2%98%85)](https://github.com/firzenyogesh/minecraft-bedrock/) 
[![GitHub Issues](https://img.shields.io/github/issues-raw/firzenyogesh/minecraft-bedrock.svg)](https://github.com/firzenyogesh/minecraft-bedrock/issues)
[![Github Contributers](https://img.shields.io/github/contributors/firzenyogesh/minecraft-bedrock.svg)](https://github.com/firzenyogesh/minecraft-bedrock/) 
[![Github Forks](https://img.shields.io/github/forks/firzenyogesh/minecraft-bedrock.svg?label=github%20forks)](https://github.com/firzenyogesh/minecraft-bedrock/)

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
    docker run -d -it --network=host firzenyogesh/minecraft-bedrock
    ```

### Advanced Settings

The above method is to start the server quick. There is a chance that you will lose your world's progress, if this container is updated (*eg. new server version*). To overcome that we use volume. We mount on a path that is outside the container

``` Docker
docker run -d -it -v "/minecraft:/srv/minecraft" --network=host firzenyogesh/minecraft-bedrock
```

**Assuming `/minecraft` is the path to mount in your machine. Change the path to your preference**

- This will create the folders `worlds`, `resource_packs`, `behavior_packs`, `premium_cache`, `world_templates`, and `properties_for_worlds` in the path `/minecraft`

- This will create the files `invalid_known_packs.json`, `valid_known_packs.json` in the path `/minecraft`

- If you have custom properties for the existing world like different `server.properties` or `whitelist.json` or `permissions.json`, these files go inside the path **`/minecraft/properties_for_worlds/worldname/`**  where `worldname` is your existing world name. The container will use these files if you provide them in this path, otherwise it will use the default properties.

These *files and folders* are generated to easliy import your existing ***mods*** and ***worlds*** to the container.

It is **recommended** to run the above mentioned command ***once***, before importing your existing ***worlds*** and ***mods***.

You can however do that without running the command, provided you have copied the `resource_packs`, `behavior_packs` and `worlds` folders from your existing server to the path `/minecraft`. If this is not done the server won't start. So make sure that atleast `resource_packs` and `behavior_packs` are there in the `/minecraft` path.

By doing this you can safely retain your worlds and mods, even if this container is destroyed or upgraded or redeployed when needed.

### Bonus Note

- If you want your world to have different name, start the container like this:

    ``` Docker
    docker run -d -it -e WORLD=worldname --network=host firzenyogesh/minecraft-bedrock
    ```

- If you want run on different port, start the container like this:

    ``` Docker
    docker run -d -it -e PORT=19132 -e PORTv6=19133 --network=host firzenyogesh/minecraft-bedrock
    ```

- A full docker command with all the variables put in:

    ``` Docker
    docker run -d -it -e WORLD=worldname -e PORT=19132 -e PORTv6=19133 -v "/minecraft:/srv/minecraft" --network=host firzenyogesh/minecraft-bedrock
    ```

Replace `worldname` with what you prefer.

Replace `/minecraft` to the path you prefer.

### Stopping the server and the container

1. To stop the `Minecraft` server

    ``` Docker
    docker attach <container id>
    ```

    - Once the container is attached run the command `Stop`, you should be seeing **Quit correctly** message

    - To get out of the attached container use `Ctrl + p + q`, if you use other combination it may not work.

2. To stop the container

    ``` Docker
    docker container stop <container id>
    ```

You can get the container id by running the following command

``` Docker
docker ps | grep firzenyogesh/minecraft-bedrock
```

This will list only the server container, use the container id you get in the result of that command.

Hope this helps out everyone, and **Happy Minecrafting ⛏️**