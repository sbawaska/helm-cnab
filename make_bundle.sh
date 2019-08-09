#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

chart_name=$1
chart_url=$2

sedi () {
    sed --version >/dev/null 2>&1 && sed -i -- "$@" || sed -i "" "$@"
}

cp cnab/Dockerfile Dockerfile.tmp
sedi "s*chart_name*${chart_name}*g" Dockerfile.tmp
sedi "s*chart_url*${chart_url}*g" Dockerfile.tmp
mv Dockerfile.tmp cnab/Dockerfile

cat duffle.json | jq ".name = \"${chart_name}\"" > duffle.json.tmp
mv duffle.json.tmp duffle.json
