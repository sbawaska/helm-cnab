#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

chart_name=$1
chart_url=$2

mv cnab/Dockerfile Dockerfile.tmp
sed -i "s/chart_name/${chart_name}/g" Dockerfile.tmp
sed -i "s/chart_url/${chart_url}/g" Dockerfile.tmp
mv Dockerfile.tmp cnab/Dockerfile

cat duffle.json | jq ".name = \"${chart_name}\"" > duffle.json.tmp
mv duffle.json.tmp duffle.json
