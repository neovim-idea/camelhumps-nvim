#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

ROCKS_TREE="$ROOT/.rocks"
mkdir -p "$ROCKS_TREE"

# Detect if brew exists and find if it has lua installed; otherwise we assume it is already installed on the system
if command -v brew &> /dev/null; then
  LUADIR="$(brew --prefix luajit)"
else
  # Fallback for CI / GitHub Actions, assume lua/luarocks in PATH
  LUADIR=""
fi

# Check whether busted is already installed in the local tree
if ! luarocks ${LUADIR:+--lua-dir="$LUADIR"} --lua-version=5.1 --tree="$ROCKS_TREE" list busted | grep -q busted; then
  echo "Installing busted (not found in local tree)..."
  luarocks ${LUADIR:+--lua-dir="$LUADIR"} --lua-version=5.1 --tree="$ROCKS_TREE" install busted
fi

# Set up paths from local tree
eval "$(luarocks ${LUADIR:+--lua-dir="$LUADIR"} --lua-version=5.1 --tree="$ROCKS_TREE" path --bin)"

# Run tests
"$ROCKS_TREE/bin/busted" -v --no-defer-print tests
