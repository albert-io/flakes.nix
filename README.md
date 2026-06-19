# flakes.nix

A small collection of Nix-packaged tools.

## Packages

### depot

Official command line interface for the Depot API.

```sh
nix run .#depot -- --help
```

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

### playwright-cli

Playwright's agent CLI (`@playwright/cli`) — drive a browser through per-command terminal calls.

```sh
nix run .#playwright-cli -- --help
```

## Updating

Each package has its own `packages/<name>/nix-update-args`, so each package can be updated from the repository root with `nix-update`:

```sh
nix run nixpkgs#nix-update -- depot
nix run nixpkgs#nix-update -- dexter
nix run nixpkgs#nix-update -- honeybadger-mcp-server
nix run nixpkgs#nix-update -- playwright-cli
```
