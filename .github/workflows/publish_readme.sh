#!/bin/sh -eux

readme_path="$1"

token="$(
  curl \
    -fsSL \
    -X POST \
    -H "Content-Type: application/json" \
    -d @- \
    https://hub.docker.com/v2/users/login/ << END | jq -r .token
{
  "username": "${INPUT_USERNAME}",
  "password": "${INPUT_PASSWORD}"
}
END
)"

message='{
  "full_description": $readme
}'
jq -n --arg readme "$(cat "${readme_path}")" "${message}" |
curl \
  -vfsSL \
  -X PATCH \
  -H "Content-Type: application/json; charset=UTF-8" \
  -H "Authorization: JWT ${token}" \
  -d @- \
  "https://hub.docker.com/v2/repositories/${INPUT_REPOSITORY}/"
