#!/usr/bin/env bash
# apply-template.sh
#
# Run this from inside a project folder right after `npm create sanity@latest`.
# It pulls this template and overwrites Sanity's default scaffold with the
# standard schema stubs, structure.js, components, and sanity.config.js —
# then restores the real projectId/dataset the CLI just generated, since the
# template's sanity.config.js only has placeholders for those.
#
# Keep a copy of this script somewhere permanent on your machine (it doesn't
# need to live inside the fresh project first) — e.g. ~/dev-scripts/ — and
# run it with `bash ~/dev-scripts/apply-template.sh` from each new project.

set -e

TEMPLATE_REPO="latz09/latz-cms-template"
TMP_DIR=".template-tmp"

extract_env_var() {
  local key="$1"
  if [ -f .env ]; then
    grep "^${key}=" .env | head -n1 | cut -d'=' -f2- | tr -d '"\r'
  fi
}

# Grab the real projectId/dataset the CLI just wrote, before we overwrite
# sanity.config.js with the template's placeholder version.
PROJECT_ID=$(extract_env_var "SANITY_STUDIO_PROJECT_ID")
DATASET=$(extract_env_var "SANITY_STUDIO_DATASET")

echo "Pulling template from ${TEMPLATE_REPO}..."
npx degit "${TEMPLATE_REPO}" "${TMP_DIR}" --force

echo "Overlaying standard files..."
cp -r "${TMP_DIR}/schemaTypes" .
cp "${TMP_DIR}/structure.js" .
cp -r "${TMP_DIR}/components" .
cp "${TMP_DIR}/sanity.config.js" .

rm -rf "${TMP_DIR}"

if [ -n "$PROJECT_ID" ]; then
  sed -i.bak "s/projectId: 'PROJECT_ID'/projectId: '${PROJECT_ID}'/" sanity.config.js
  echo "  projectId restored: ${PROJECT_ID}"
else
  echo "  WARNING: no .env found — set projectId in sanity.config.js manually."
fi

if [ -n "$DATASET" ]; then
  sed -i.bak "s/dataset: 'production'/dataset: '${DATASET}'/" sanity.config.js
fi
rm -f sanity.config.js.bak

echo ""
echo "Done. Left to do:"
echo "  1. Set 'title' in sanity.config.js to the client's name"
echo "  2. Drop client-logo.png and cms-guide.pdf into static/"
echo "  3. Run 'npm run dev' to confirm it boots clean"
echo "  4. Run the schema/query/page generator"