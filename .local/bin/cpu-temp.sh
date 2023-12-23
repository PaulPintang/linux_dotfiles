#!/bin/sh

sensors | grep "Core 0" | awk '{gsub(/\+/,"",$3); sub(/^0/,"",$3); printf "%s%d°C\n", $3, $2}'

