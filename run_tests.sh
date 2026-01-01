#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

LUADIR="$(brew --prefix luajit)"
luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree=.rocks install busted
eval "$(luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree="$(pwd)/.rocks" path --bin)"
.rocks/bin/busted -v --no-defer-print tests
