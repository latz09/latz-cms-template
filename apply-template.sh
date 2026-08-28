#!/usr/bin/env bash
# apply-template.sh
#
# Run this from inside a project folder right after `npm create sanity@latest`.
# It pulls this template and overwrites Sanity's default scaffold with the
# standard schema stubs, structure.js, components, and sanity.config.js.
#
# Keep a copy of this script somewhere permanent on your machine (it doesn't
# need to live inside the fresh project first) — e.g. ~/dev-scripts/ — and
# run it with `bash ~/dev-scripts/apply-template.sh` from each new project.

set -e

# TODO: set this to your actual GitHub path once the template repo is pushed
TEMPLATE_REPO="YOUR_GITHUB_USERNAME/latz-sanity-studio-template"
TMP_DIR=".template-tmp"

echo "Pulling template from ${TEMPLATE_REPO}..."
npx degit "${TEMPLATE_REPO}" "${TMP_DIR}" --force

echo "Overlaying standard files..."
cp -r "${TMP_DIR}/schemaTypes" .
cp "${TMP_DIR}/structure.js" .
cp -r "${TMP_DIR}/components" .
cp "${TMP_DIR}/sanity.config.js" .

rm -rf "${TMP_DIR}"

echo ""
echo "Done. Left to do:"
echo "  1. Set 'title' in sanity.config.js to the client's name"
echo "  2. Drop client-logo.png and cms-guide.pdf into static/"
echo "  3. Run 'npm run dev' to confirm it boots clean"
echo "  4. Run the schema/query/page generator"
