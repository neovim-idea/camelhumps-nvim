#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

# exec "busted" "$ROOT/tests/spec"


# nvim --headless -c "PlenaryBustedDirectory tests/ { minimal_init = 'tests/minimal_init.lua' }"


# nvim --headless -u tests/minimal_init.lua -l tests/run_busted.lua
# exec nvim --headless -u tests/minimal_init.lua -l "$@"``
# busted --lua=./scripts/nlua tests
LUADIR="$(brew --prefix luajit)"
luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree=.rocks install busted
eval "$(luarocks --lua-dir="$LUADIR" --lua-version=5.1 --tree="$(pwd)/.rocks" path --bin)"
.rocks/bin/busted -v --no-defer-print tests
