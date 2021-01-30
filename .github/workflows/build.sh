#!/bin/sh -eux

suffix="${GOOS}_${GOARCH}"
if [ "${GOOS}" = windows ]; then
    suffix="${suffix}.exe"
fi
filename="app-${suffix}"

go build -o "${filename}" .

cat << EOF
::set-output name=filename::${filename}
EOF
