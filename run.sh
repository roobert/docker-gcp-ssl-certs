#!/usr/bin/env bash

INTERVAL="${1}"
COMMAND="${2}"

while sleep "${INTERVAL}"; do
  ${COMMAND}
done
