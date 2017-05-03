#!/usr/bin/env bash

INTERVAL="${1}"
COMMAND="${2}"
FILE="${3}"

while sleep "${INTERVAL}"; do
  ${COMMAND} | tee "${FILE}.new"
  if [[ $? -ne 0 ]]; then
    break
  fi
  cp -v "${FILE}.new" "${FILE}"
  rm "${FILE}.new"
done
