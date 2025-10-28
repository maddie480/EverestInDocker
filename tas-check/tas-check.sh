#!/bin/bash

set -xeo pipefail

curl --fail -Lo "/home/ubuntu/celeste/Mods/$1.zip" "$2"

./Celeste --sync-check-file "/home/ubuntu/${TAS_PATH}" --sync-check-result /home/ubuntu/tas-result.json
[ "`jq -r '.entries[].status' /home/ubuntu/tas-result.json`" == "success" ]