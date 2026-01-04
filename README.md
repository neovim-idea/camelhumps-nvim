<div align="center">

[![GitHub Tag](https://img.shields.io/github/v/tag/neovim-idea/camelhumps-nvim?sort=semver&style=for-the-badge)](https://github.com/neovim-idea/camelhumps-nvim/releases)
[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.10+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

## camelhumps-nvim

###### JetBrain's smart cursor motions, for neovim :heart_eyes:

![camelhumps-nvim usage](docs/demo_130x30.gif "camelhumps usage")

</div>

* [Usage](#usage)
* [Installation](#installation)
  * [Lazy](#lazy)
  * [Packer](#packer)
  * [Plug](#plug)
* [Setup](#setup)
* [Development](#development)
* [Todo](#todo)
* [Buy me a :beer:](#buy-me-a-beer)

<!-- TOC -->


## Usage

Hold `Control` (or `Opt`, if you're on a Mac) + `Left` (or `h`, if you're a neovim purist) to jump to the closest symbol,
beginning of word, or uppercase character inside a word that is on the left of the current cursor position. Use
`<Right>` (or `l`) to move to the right, using the same logic.

Hold `Control` (or `Opt`) + `Backspace` to delete what's on the left of the cursor, using the same smart logic for the
jump; use `Del` to delete, instead, what's on its right.


## Installation

### Lazy

> [!IMPORTANT]
> The plugin must NOT be lazy loaded!


```lua
{
  "neovim-idea/camelhumps-nvim",
  lazy = false,
}
```

### Packer

```lua
use {
  "neovim-idea/camelhumps-nvim",
}
```

### Plug

```lua
Plug "neovim-idea/camelhumps-nvim"
```


## Setup

In your `config` function, simply add the following lines:

```lua
local camelhumps = require("camelhumps").setup()
vim.keymap.set({ "n", "i", "v" }, "<M-Left>", camelhump.left, { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<M-Right>", camelhump.right, { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<M-BS>", camelhump.left_delete, { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<M-Del>", camelhump.right_delete, { noremap = true, silent = true })
```

As you might have guessed, the plugin exposes four, high level methods:

* `left()`, to move the cursor to the left
* `right()`, to move the cursor to the right
* `left_delete()`, to delete text on the left of the cursor
* `right_delete()`, to delete text on the right of the cursor


## Development

Install `lua`, `luarocks` and `busted`, usually via `brew` as such:

```bash
brew install lua luarocks busted
```

Then, you can run the tests like so

```bash
chmod +x run_tests.sh
./run_tests.sh
```


## Todo

- [ ] recognise enums such as `FOO_BAR_BAZ` ad jump them altogether
- [ ] have a round of checks on the tests and make sure to document behaviours diverging from IntelliJ
- [ ] `left/right{_delete}` have quite some duplicate code: make it centralized
- [ ] wrap internal functions that are testsed into a `_private` module, and export them if `_G.testing_enabled == true`
- [x] make `run_tests.sh` detect if deps are already installed and, if so, skip the process


## Buy me a :beer:

BTC `12CQ1L7qQvF3pPXhAgomnSfWaVkL19nV5F` 
