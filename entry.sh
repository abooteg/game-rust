#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
                +login anonymous \
				+app_update "${STEAMAPPID}" \
				+quit

# Believe it or not, if you don't do this srcds_run shits itself
cd "${STEAMAPPDIR}"

./RustDedicated -batchmode -nographics -keeplog +server.ip "${RUST_SERVER_IP}" \
            +server.port "${RUST_SERVER_PORT}" +app.listenip "${RUST_APP_IP}" +app.publicip "${RUST_APP_PUBLIC_IP}" +rcon.ip "${RUST_RCON_IP}" \
			+rcon.port "${RUST_RCON_PORT}" +rcon.password "${RUST_RCON_PASSWORD}" +oxide.directory "server/survivalhost.org/oxide" \
			+server.radiation "${RUST_SERVER_RADIATION}" +server.hostname "${RUST_SERVER_HOSTNAME}" +server.identity "survivalhost.org" \
			+server.level "${RUST_SERVER_LEVEL}" +server.seed "${RUST_SERVER_SEED}" +server.maxplayers "${RUST_SERVER_MAXPLAYERS}" \
			+fps.limit "${RUST_FPS_LIMIT}" +server.worldsize "${RUST_SERVER_WORLDSIZE}" +server.saveinterval "${RUST_SERVER_SAVEINTERVAL}" \
			+server.secure "${RUST_SERVER_SECURE}" +server.url "${RUST_SERVER_URL}" +server.headerimage "${RUST_SERVER_HEADERIMAGE}" \
			+server.salt "${RUST_SERVER_SALT}" +server.encryption ${RUST_SERVER_ENCRYPTION} \
			+craft.instant ${RUST_CRAFT_INSTANT} ${RUST_LEVELURL} ${RUST_MAPURL} -logfile ${STEAMAPPDIR}\server\survivalhost.org\server_log\console.log \
			+server.tags "${RUST_SERVER_TAGS}" +server.gamemode "${RUST_SERVER_GAMEMODE}" +server.description "${RUST_SERVER_DESCRIPTION}" \
			"${ADDITIONAL_ARGS}"