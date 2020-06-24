FROM ubuntu:latest

# setup envs
ENV WORLD='DefaultWorld'
ENV PORT=19132
ENV PORTv6=19133
ENV MINECRAFT_COMMON_PATH='/srv/minecraft'
ARG INSTALL_URL='https://minecraft.azureedge.net/bin-linux/bedrock-server-1.16.0.2.zip'
ENV SERVER_PATH='/srv/bedrock-server'
ENV SERVER_ESSENTIALS='/srv/essentials'

EXPOSE ${PORT}/tcp
EXPOSE ${PORTv6}/tcp
EXPOSE ${PORT}/udp
EXPOSE ${PORTv6}/udp

VOLUME ${MINECRAFT_COMMON_PATH}

# install minecraft server
RUN apt-get update
RUN apt-get install -y unzip curl libcurl4 libssl1.0.0
RUN curl ${INSTALL_URL} --output ${SERVER_PATH}.zip
RUN unzip ${SERVER_PATH}.zip -d ${SERVER_PATH}
RUN rm ${SERVER_PATH}.zip

# server essentials
COPY server.properties.template ${SERVER_ESSENTIALS}/_templates/server.properties.template
COPY permissions.json.template ${SERVER_ESSENTIALS}/_templates/permissions.json.template
COPY whitelist.json.template ${SERVER_ESSENTIALS}/_templates/whitelist.json.template

COPY startup.sh /srv/essentials/startup.sh
RUN chmod a+x /srv/essentials/startup.sh
ENTRYPOINT [ "/srv/essentials/startup.sh" ]
