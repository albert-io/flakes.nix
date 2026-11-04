# flakes.nix

A small collection of Nix-packaged tools.

Packages are available for x86-64 Linux, ARM64 Linux, and Apple Silicon macOS.
The current nixpkgs input no longer supports Intel macOS.

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

### honeybadger-cli

Official command line interface for the Honeybadger API.

```sh
nix run .#honeybadger-cli -- --help
```

### honeybadger-mcp-server

Honeybadger MCP Server.

Current upstream uses Honeybadger's v3 Data API. Set `HONEYBADGER_PERSONAL_AUTH_TOKEN`
to an API Token. Legacy personal auth tokens no longer work. See the
[upstream upgrade notes](https://github.com/honeybadger-io/honeybadger-mcp-server#upgrading-to-the-v3-data-api)
for credential and tool changes.

```sh
nix run .#honeybadger-mcp-server -- --help
```

### playwright-cli

Playwright's agent CLI (`@playwright/cli`) — drive a browser through per-command terminal calls.

```sh
nix run .#playwright-cli -- --help
```

### tidewave-cli

Tidewave's Elixir/Phoenix runtime introspection tools (`eval`/`sql`/`logs`/…) as plain shell commands, for when the MCP server isn't usable (e.g. an agent that started its own backend this session).

```sh
nix run .#tidewave-cli -- --help
```

## Updating

Each package has its own `packages/<name>/nix-update-args`, so each package can be updated from the repository root with `nix-update`:

```sh
nix run nixpkgs#nix-update -- depot
nix run nixpkgs#nix-update -- dexter
nix run nixpkgs#nix-update -- honeybadger-cli
nix run nixpkgs#nix-update -- honeybadger-mcp-server
nix run nixpkgs#nix-update -- playwright-cli
nix run nixpkgs#nix-update -- tidewave-cli
```
