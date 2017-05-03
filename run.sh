#!/usr/bin/env bash

INTERVAL="${1}"
COMMAND="${2}"
FILE="${3}"

while sleep "${INTERVAL}"; do
  ${COMMAND} | tee "${FILE}.new"
  if [[ $? -ne 0 ]]; then
    break
  fi
  mv -v "${FILE}.new" "${FILE}"
done
