#!/bin/bash

set -x
set -o errexit
set -o nounset
set -o pipefail

args=( "$@" )

sedi () {
    sed --version >/dev/null 2>&1 && sed -i -- "$@" || sed -i "" "$@"
}

cp cnab/Dockerfile Dockerfile.tmp
for (( counter=0; counter<$#; counter+=2 )); do
    helm_add+="  \&\& helm repo add ${args[$counter]} ${args[$counter+1]} "
done

sedi "s*  && helm repo add chart_name chart_url*${helm_add}*g" Dockerfile.tmp
mv Dockerfile.tmp cnab/Dockerfile
cp cnab/app/run run.sh
for (( counter=0; counter<$#; counter+=2 )); do
    helm_install+="helm install \${CNAB_INSTALLATION_NAME}_${args[$counter]} ${args[$counter]}/${args[$counter]} "
    if [[ counter+2 -lt $# ]]; then
        helm_install+=" \&\& "
    fi
done

sedi "s*helm install \${CNAB_INSTALLATION_NAME} chart_name/chart_name*${helm_install}*g" run.sh
mv run.sh cnab/app/run
chmod +x cnab/app/run
duffle build .
