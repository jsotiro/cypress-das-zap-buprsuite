#!/bin/bash
echo $1
CERTS_DIR="./certs"
if [ ! -d "${1}" ]; then
    mkdir $1
fi
filename="$1/zap_report.html"

echo "saving $filename"
curl http://localhost:8080/OTHER/core/other/htmlreport/? > $filename
