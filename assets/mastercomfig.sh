#!/bin/bash

DIRNAME="out"

function build {
    local sdir="$DIRNAME/mastercomfig/presets/mastercomfig-$1-preset/cfg"
    local dfile="../$2/cfg/autoexec.cfg"
    awk '{print};ENDFILE{print ""}' "$sdir/comfig/comfig.cfg" "$sdir/presets/$1.cfg" "$sdir/comfig/modules_run.cfg" "$sdir/comfig/finalize.cfg" > "$dfile"
    unix2dos -q "$dfile"
}

if [ -d "$DIRNAME" ]; then
    echo "Removing existing temporary directory..."
    rm -rf "$DIRNAME"
fi

echo "Creating temporary directory..."
mkdir -p "$DIRNAME"

echo "Downloading mastercomfig sources..."
curl -L "https://github.com/mastercomfig/mastercomfig/releases/latest/download/mastercomfig.zip" -o "$DIRNAME/mastercomfig.zip" >/dev/null 2>&1

echo "Unpacking downloaded archive..."
unzip "$DIRNAME/mastercomfig.zip" -d "$DIRNAME/mastercomfig" >/dev/null 2>&1

echo "Generating standalone version with low preset..."
build low mastercomfigpf

echo "Generating standalone version with ultra preset..."
build ultra mastercomfigmq

echo "Removing temporary directory..."
rm -rf "$DIRNAME"
