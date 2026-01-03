## camelhumps-nvim

add description here


## Development

Install `lua`, `luarocks` and `busted`

```bash
brew install lua luarocks busted
```

Run the tests

```bash
chmod +x run_tests.sh
./run_tests.sh
```


## Todo

- [ ] recognise enums such as `FOO_BAR_BAZ` ad jump them altogether
- [ ] have a round of checks on the tests and make sure to document behaviours diverging from IntelliJ
- [ ] make `run_tests.sh` work offline: test if busted is installed, then install
