#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

LUADIR="$(brew --prefix luajit)"
ROCKS_TREE="$ROOT/.rocks"

mkdir -p "$ROCKS_TREE"

# Check whether busted is already installed in the local tree
if ! luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree="$ROCKS_TREE" list busted | grep -q busted; then
  echo "Installing busted (not found in local tree)..."
  luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree="$ROCKS_TREE" install busted
fi

# Set up paths from local tree & run tests
eval "$(luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree="$ROCKS_TREE" path --bin)"
"$ROCKS_TREE/bin/busted" -v --no-defer-print tests
