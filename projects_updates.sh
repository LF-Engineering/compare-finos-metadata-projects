#!/bin/bash
if [ -z "${1}" ]
then
  echo "$0: please provide a source commit SHA to compare with: example: e7807d2ffb6cc1ad2a467ee9aa91472694f3261e"
  exit 1
fi
src="${1}"
if [ -z "${2}" ]
then
  dst=HEAD
else
  dst="${2}"
fi
fsrc="projects.json.${src}"
fdst="projects.json.${dst}"
echo "${src} -> ${dst} projects.json changes:"
cleanup() {
  echo "rm -f \"${fsrc}\" \"${fsrc}.tmp\" \"${fdst}\" \"${fdst}.tmp\" \"projects.json.diff\""
}
trap cleanup EXIT
set -o pipefail
git show "${src}:projects.json" > "${fsrc}" || exit 2
git show "${dst}:projects.json" > "${fdst}" || exit 3
vim -c 'g/^\/\//d' -c 'g/^\s*$/d' -c wq "${fsrc}" || exit 4
vim -c 'g/^\/\//d' -c 'g/^\s*$/d' -c wq "${fdst}" || exit 5
cat "${fsrc}" | jq -rS '.' > "${fsrc}.tmp" || exit 5
mv "${fsrc}.tmp" "${fsrc}"
cat "${fdst}" | jq -rS '.' > "${fdst}.tmp" || exit 6
mv "${fdst}.tmp" "${fdst}"
diff "${fsrc}" "${fdst}" > projects.json.diff
cat projects.json.diff
