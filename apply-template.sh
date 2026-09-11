#!/usr/bin/env bash
# apply-template.sh
#
# Run this from inside a project folder right after `npm create sanity@latest`.
# It pulls this template and overwrites Sanity's default scaffold with the
# standard schema stubs, structure.js, components, and sanity.config.js —
# then restores the real projectId/dataset the CLI just wrote into the
# scaffolded sanity.config.js, before that file gets replaced.
#
# Keep a copy of this script somewhere permanent on your machine (it doesn't
# need to live inside the fresh project first) — e.g. ~/dev-scripts/ — and
# run it with `bash ~/dev-scripts/apply-template.sh` from each new project.

set -e

TEMPLATE_REPO="latz09/latz-cms-template"
TMP_DIR=".template-tmp"

extract_config_value() {
  local key="$1"
  if [ -f sanity.config.js ]; then
    grep -m1 "${key}:" sanity.config.js | sed -E "s/.*${key}:[[:space:]]*['\"]([^'\"]+)['\"].*/\1/"
  fi
}

# Grab the real projectId/dataset the CLI just wrote, before we overwrite
# sanity.config.js with the template's placeholder version. Reading it from
# this file (rather than .env) doesn't depend on any particular CLI prompt —
# the Studio can't run without a real projectId here, so it's always present.
PROJECT_ID=$(extract_config_value "projectId")
DATASET=$(extract_config_value "dataset")

echo "Pulling template from ${TEMPLATE_REPO}..."
npx degit "${TEMPLATE_REPO}" "${TMP_DIR}" --force

echo "Overlaying standard files..."
cp -r "${TMP_DIR}/schemaTypes" .
cp "${TMP_DIR}/structure.js" .
cp -r "${TMP_DIR}/components" .
cp "${TMP_DIR}/sanity.config.js" .

rm -rf "${TMP_DIR}"

echo "Installing @sanity/themer..."
npm install @sanity/themer

if [ -n "$PROJECT_ID" ]; then
  sed -i.bak "s/projectId: 'PROJECT_ID'/projectId: '${PROJECT_ID}'/" sanity.config.js
  echo "  projectId restored: ${PROJECT_ID}"
else
  echo "  WARNING: couldn't find projectId in the scaffolded sanity.config.js — set it manually."
fi

if [ -n "$DATASET" ]; then
  sed -i.bak "s/dataset: 'production'/dataset: '${DATASET}'/" sanity.config.js
  echo "  dataset restored: ${DATASET}"
fi
rm -f sanity.config.js.bak

if [ ! -d node_modules/@sanity/themer ]; then
  echo ""
  echo "WARNING: @sanity/themer isn't in node_modules — the install step"
  echo "may have silently failed. Run 'npm ls @sanity/themer' to confirm,"
  echo "and 'npm install @sanity/themer' manually if it's missing."
fi

echo ""
echo "Done. Left to do:"
echo "  1. Set 'title' in sanity.config.js to the client's name"
echo "  2. Drop client-logo.png and cms-guide.pdf into static/"
echo "  3. Run 'npm run dev' to confirm it boots clean"
echo "  4. Run the schema/query/page generator"