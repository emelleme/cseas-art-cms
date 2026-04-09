#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WRANGLER_BIN="${WRANGLER_BIN:-$ROOT_DIR/node_modules/.bin/wrangler}"
NODE_BIN="${NODE_BIN:-/home/toby/.nvm/versions/node/v24.14.1/bin/node}"
DB_NAME="${D1_DATABASE_NAME:-cseas-db}"
MODE="${1:---remote}"

if [[ "$MODE" != "--remote" && "$MODE" != "--local" ]]; then
  echo "Usage: $0 [--remote|--local]" >&2
  exit 1
fi

run_wrangler() {
  "$NODE_BIN" "$WRANGLER_BIN" d1 execute "$DB_NAME" "$MODE" "$@"
}

get_columns() {
  local table="$1"

  run_wrangler --command "PRAGMA table_info('$table');" 2>&1 | python3 -c '
import json
import sys

text = sys.stdin.read()
start = text.find("[")
if start == -1:
    raise SystemExit("Could not parse Wrangler output as JSON")

payload = json.loads(text[start:])
for row in payload[0]["results"]:
    print(row["name"])
'
}

ensure_column() {
  local table="$1"
  local column="$2"
  local column_type="$3"

  if get_columns "$table" | grep -Fxq "$column"; then
    echo "Column already present: $table.$column"
    return
  fi

  echo "Adding missing column: $table.$column ($column_type)"
  run_wrangler --command "ALTER TABLE \"$table\" ADD COLUMN \"$column\" $column_type;"
}

ensure_column "ec_opcat_collections" "subtitle" "TEXT"
ensure_column "ec_opcat_collections" "description" "JSON"
ensure_column "ec_opcat_collections" "theme_gradient" "TEXT"
ensure_column "ec_opcat_collections" "featured_model" "TEXT"
ensure_column "ec_opcat_collections" "opcat_contract" "TEXT"
ensure_column "ec_opcat_collections" "minter_type" "TEXT"
ensure_column "ec_opcat_collections" "covenant_preview" "JSON"

ensure_column "ec_opcat_artworks" "collection" "TEXT"
ensure_column "ec_opcat_artworks" "featured_image" "TEXT"
ensure_column "ec_opcat_artworks" "model_3d" "TEXT"
ensure_column "ec_opcat_artworks" "splat_url" "TEXT"
ensure_column "ec_opcat_artworks" "description" "JSON"
ensure_column "ec_opcat_artworks" "cat721_token_id" "TEXT"
ensure_column "ec_opcat_artworks" "cat721_txid" "TEXT"
ensure_column "ec_opcat_artworks" "covenant_hash" "TEXT"
ensure_column "ec_opcat_artworks" "geo_location" "JSON"
ensure_column "ec_opcat_artworks" "xr_settings" "JSON"
ensure_column "ec_opcat_artworks" "fractional_holders" "JSON"
ensure_column "ec_opcat_artworks" "attributes" "JSON"
ensure_column "ec_opcat_artworks" "content_type" "TEXT"
ensure_column "ec_opcat_artworks" "content_body" "TEXT"

echo "OPCAT schema repair complete for $DB_NAME ($MODE)."
