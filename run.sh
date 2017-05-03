#!/usr/bin/env bash

INTERVAL="${1}"
shift
COMMAND="${@}"

while sleep "${INTERVAL}"; do
  ${COMMAND}
done
