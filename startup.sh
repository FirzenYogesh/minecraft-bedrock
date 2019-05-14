#! /bin/bash

# prepare all the common files and folders

# if the directories do not exist, create it
mkdir -p -- "${MINECRAFT_COMMON_PATH}/worlds"
mkdir -p -- "${MINECRAFT_COMMON_PATH}/premium_cache"
mkdir -p -- "${MINECRAFT_COMMON_PATH}/world_templates"

# copy the existing packs to the common path
cp -r "${SERVER_PATH}/resource_packs" "${MINECRAFT_COMMON_PATH}/"
cp -r "${SERVER_PATH}/behavior_packs" "${MINECRAFT_COMMON_PATH}/"

# if the files do not exist, create it
if ! [ -f "${MINECRAFT_COMMON_PATH}/invalid_known_packs.json" ]; then
    echo "[]" > "${MINECRAFT_COMMON_PATH}/invalid_known_packs.json"
fi

if ! [ -f "${MINECRAFT_COMMON_PATH}/valid_known_packs.json" ]; then
    echo "[]" > "${MINECRAFT_COMMON_PATH}/valid_known_packs.json"
fi

# if custom properties folder does not exist, create it
mkdir -p -- "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}"

# use the templates if custom properties are not there
if ! [ -f "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/server.properties" ]; then
    cp "${SERVER_ESSENTIALS}/_templates/server.properties.template" "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/server.properties"
fi

if ! [ -f "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/permissions.json" ]; then
    cp "${SERVER_ESSENTIALS}/_templates/permissions.json.template" "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/permissions.json"
fi

if ! [ -f "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/whitelist.json" ]; then
    cp "${SERVER_ESSENTIALS}/_templates/whitelist.json.template" "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/whitelist.json"
fi

# replace the template if necessary
sed -i -e "s/=world/=$WORLD/g" "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/server.properties"
sed -i -e "s/=19132/=$PORT/g" "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/server.properties"
sed -i -e "s/=19133/=$PORTv6/g" "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/server.properties"

# remove the existing files and folders
rm -rf "${SERVER_PATH}/worlds"
rm -rf "${SERVER_PATH}/resource_packs"
rm -rf "${SERVER_PATH}/behavior_packs"
rm -rf "${SERVER_PATH}/premium_cache"
rm -rf "${SERVER_PATH}/world_templates"
rm -f "${SERVER_PATH}/server.properties"
rm -f "${SERVER_PATH}/permissions.json"
rm -f "${SERVER_PATH}/whitelist.json"
rm -f "${SERVER_PATH}/valid_known_packs.json"
rm -f "${SERVER_PATH}/invalid_known_packs.json"

# create soft links to the common files and folders
ln -s "${MINECRAFT_COMMON_PATH}/worlds" "${SERVER_PATH}/worlds"
ln -s "${MINECRAFT_COMMON_PATH}/resource_packs" "${SERVER_PATH}/resource_packs"
ln -s "${MINECRAFT_COMMON_PATH}/behavior_packs" "${SERVER_PATH}/behavior_packs"
ln -s "${MINECRAFT_COMMON_PATH}/premium_cache" "${SERVER_PATH}/premium_cache"
ln -s "${MINECRAFT_COMMON_PATH}/world_templates" "${SERVER_PATH}/world_templates"
ln -s "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/server.properties" "${SERVER_PATH}/server.properties"
ln -s "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/permissions.json" "${SERVER_PATH}/permissions.json"
ln -s "${MINECRAFT_COMMON_PATH}/properties_for_the_worlds/${WORLD}/whitelist.json" "${SERVER_PATH}/whitelist.json"
ln -s "${MINECRAFT_COMMON_PATH}/valid_known_packs.json" "${SERVER_PATH}/valid_known_packs.json"
ln -s "${MINECRAFT_COMMON_PATH}/invalid_known_packs.json" "${SERVER_PATH}/invalid_known_packs.json"

echo "Starting server: ${WORLD} on ${HOSTNAME}:${PORT} ..."

cd ${SERVER_PATH}

LD_LIBRARY_PATH=. ./bedrock_server
