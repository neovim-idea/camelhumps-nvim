<div align="center">

[![GitHub Tag](https://img.shields.io/github/v/tag/neovim-idea/camelhumps-nvim?sort=semver&style=for-the-badge)](https://github.com/neovim-idea/switcher-nvim/releases)
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

`Control` (or `Opt`, if you're on a Mac) + `Left` (or `h`, if you're a neovim purist) to jump to the closest symbol,
beginning of word, or uppercase character inside a word that is on the left of the current cursor position.

Change to `<Right>` (or `l`) to move to the right, using the same logic.


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
vim.keymap.set({ "n", "i", "v" }, "<M-Left>", camelhumps.left, { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<M-Right>", camelhumps.right, { noremap = true, silent = true })
```


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
- [x] make `run_tests.sh` detect if deps are already installed and, if so, skip the process


## Buy me a :beer:

BTC `12CQ1L7qQvF3pPXhAgomnSfWaVkL19nV5F` 
