# Repository guide

A flake exposing a handful of Nix-packaged CLI tools. Each package lives under `packages/<name>/` and is wired into the flake, the legacy `default.nix`, the overlay, all three CI workflows, and the README.

## Adding a new package

1. Create `packages/<name>/`:
   - `package.nix` — the derivation. Model after an existing sibling (`dexter` for Go + shell completions, `honeybadger-mcp-server` for a minimal Go build). Start `src.hash` and `vendorHash` at `lib.fakeHash`.
   - `default.nix` — one-liner: `{ pkgs }: pkgs.callPackage ./package.nix { }`.
   - `nix-update-args` — args passed to `nix-update`. `--use-github-releases` for tagged releases, `--version=branch` for unstable HEAD tracking.
2. Register the package in three places (keep the lists alphabetized):
   - `flake.nix` — under `packages = eachSystem (...)`.
   - `default.nix` — the legacy entrypoint mirrors the flake outputs.
   - `overlays/default.nix`.
3. Wire CI in `.github/workflows/`:
   - `check.yml` — add a `Build <name>` step.
   - `publish-cache.yml` — add a `Build <name>` step.
   - `update.yml` — add `<name>` to both the `workflow_dispatch` `options:` list and the `matrix.package` list.
4. Document it in `README.md` — add a section under Packages and an entry under the `nix-update` list.

## Resolving fake hashes

Build twice with `lib.fakeHash` placeholders — the build prints the real hashes:

```sh
nix build .#<name> --no-link 2>&1 | tail
```

First failure reports the `src` hash; replace `src.hash` and rebuild. Second failure reports the `vendorHash`; replace it and rebuild. The third build should succeed.

## Local verification

```sh
nix build .#<name> --print-build-logs       # builds the package
./result/bin/<name> --version               # smoke-test the binary
nix flake show --allow-import-from-derivation
nix flake check --allow-import-from-derivation
nix run nixpkgs#actionlint                  # lint the workflow YAML
```

For Go packages with shell completions, also confirm `share/{bash-completion,fish/vendor_completions.d,zsh/site-functions}/` are populated under the build output.
