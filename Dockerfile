###########################################################
# Dockerfile that builds a CSGO Gameserver
###########################################################
FROM survhost/steamcmd:root
LABEL maintainer="admin@survivalhost.org"

ENV STEAMAPPID 258550
ENV STEAMAPP rust
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/abooteg/game-rust/main/entry.sh

# Create autoupdate config
# Add entry script & ESL config
# Remove packages and tidy up
RUN set -x \
        &&  apt-get update \
        &&  apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1 \
		libsqlite3-0 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}" -O "${HOMEDIR}/entry.sh" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
                echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& rm -rf /var/lib/apt/lists/*

ENV RUST_SERVER_IP='0' \
	RUST_APP_IP='0' \
	RUST_APP_PUBLIC_IP='0' \
	RUST_RCON_IP='0' \
	RUST_RCON_PORT='0' \
	RUST_RCON_PASSWORD='passwd' \
    RUST_OXIDE_DIR='server/survivalhost.org/oxide' \
	RUST_SERVER_RADIATION='0' \
	RUST_SERVER_HOSTNAME='Hosted by hostingrust.ru' \
	RUST_SERVER_IDENTITY='hostingrust.ru' \
	RUST_SERVER_LEVEL='Barren' \
	RUST_SERVER_SEED='123456' \
	RUST_SERVER_MAXPLAYERS='100' \
	RUST_FPS_LIMIT='512' \
	RUST_SERVER_WORLDSIZE='1000' \
	RUST_SERVER_SAVEINTERVAL='300' \
	RUST_SERVER_SECURE='True' \
	RUST_SERVER_URL='hostingrust.ru' \
	RUST_SERVER_HEADERIMAGE='https://hostingrust.ru/images/game/rust-bg.jpg' \
	RUST_SERVER_SALT='123456' \
	RUST_SERVER_ENCRYPTION='1' \
	RUST_CRAFT_INSTANT='False' \
	RUST_LEVELURL='' \
	RUST_MAPURL='' \
	RUST_LOGFILE='/server/survivalhost.org/server_log/console.log' \
	RUST_SERVER_TAGS='monthly' \
	RUST_SERVER_GAMEMODE='vanilla' \
	RUST_SERVER_DESCRIPTION='Hosted by hostingrust.ru' \
	ADDITIONAL_ARGS=''

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 35000/udp \
	35001/udp \
	35002/tcp