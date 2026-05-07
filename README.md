# flakes.nix

A small collection of Nix-packaged tools.

## Packages

### dexter

Fast implementation of the Elixir language server in Go.

```sh
nix run .#dexter -- --help
```

### honeybadger-mcp-server

Honeybadger MCP Server.

```sh
nix run .#honeybadger-mcp-server -- --help
```

## Updating

Each package has its own `packages/<name>/nix-update-args`, so both packages can be updated from the repository root with `nix-update`:

```sh
nix run nixpkgs#nix-update -- dexter
nix run nixpkgs#nix-update -- honeybadger-mcp-server
```
