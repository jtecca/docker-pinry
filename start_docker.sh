#!/bin/bash



DATA_PATH=${1}
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
SETTINGS_PATH="${HERE}/pinry/local_settings.py"

if [ "${DATA_PATH}" = "" ]
then
    DATA_PATH=$(readlink -f data)
fi

# make sure the exposed port points to where gnunicorn is pointed to
sudo docker run -d=true -p=8000:8000 \
    --name pinry_app \
    -v=${DATA_PATH}:/data \
    -v=${SETTINGS_PATH}:/srv/www/pinry/pinry/settings/local_settings.py \
    pinry/pinry /scripts/start.sh
