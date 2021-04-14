#!/bin/bash
fsrc="projects_github.json"
fdst="projects_gitlab.json"
echo "${src} -> ${dst} projects.json changes:"
cleanup() {
  echo "rm -f \"${fsrc}\" \"${fsrc}.tmp\" \"${fdst}\" \"${fdst}.tmp\" \"projects.json.diff\""
}
trap cleanup EXIT
set -o pipefail
vim -c 'g/^\/\//d' -c 'g/^\s*$/d' -c wq "${fsrc}" || exit 4
vim -c 'g/^\/\//d' -c 'g/^\s*$/d' -c wq "${fdst}" || exit 5
cat "${fsrc}" | jq -rS '.' > "${fsrc}.tmp" || exit 5
mv "${fsrc}.tmp" "${fsrc}"
cat "${fdst}" | jq -rS '.' > "${fdst}.tmp" || exit 6
mv "${fdst}.tmp" "${fdst}"
diff "${fsrc}" "${fdst}" > projects.json.diff
cat projects.json.diff
