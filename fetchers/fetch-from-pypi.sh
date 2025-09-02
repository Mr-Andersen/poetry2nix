#!/usr/bin/env bash

# shellcheck disable=SC1091,SC2154
source "$stdenv/setup"
set -euo pipefail

curl="curl            \
 --location           \
 --max-redirs 20      \
 --retry 2            \
 --disable-epsv       \
 --cookie-jar cookies \
 --insecure           \
 --speed-time 5       \
 --no-progress-meter  \
 --fail               \
 $curlOpts            \
 $NIX_CURL_FLAGS"

$curl "https://pypi.org/pypi/$pname/json" | jq -r ".releases.\"$version\"[] | select(.filename == \"$file\") | .url" > url
url=$(cat url)
$curl "$url" --output "$out"
