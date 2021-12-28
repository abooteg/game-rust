#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
                +login anonymous \
				+app_update "${STEAMAPPID}" \
				+quit

# Believe it or not, if you don't do this srcds_run shits itself
cd "${STEAMAPPDIR}"

bash 