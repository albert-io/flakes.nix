{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

# @playwright/cli is not in nixpkgs. Build it straight from its source repo,
# which ships a package-lock.json — so buildNpmPackage has a lockfile and
# nix-update can bump it by git tag (see nix-update-args for the version pin).
buildNpmPackage (finalAttrs: {
  pname = "playwright-cli";
  version = "0.1.21";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ZHfQBZQejJKNYfhszd99i4GIzEpomBzX0/HkMK2T8DQ=";
  };

  npmDepsHash = "sha256-aTn5CFeAzoH4J+TYiM4HOULzWAeyU3xmD4wkQdsJrGY=";

  # Pure-JS CLI, no compile step — buildNpmPackage installs the package's
  # declared `playwright-cli` bin directly.
  dontNpmBuild = true;

  # Skip dependency install scripts. The one that matters is playwright-core's
  # postinstall browser download, which we don't want: consumers point Playwright
  # at a system browser at runtime via PLAYWRIGHT_LAUNCH_OPTIONS_EXECUTABLE_PATH.
  npmFlags = [ "--ignore-scripts" ];

  meta = {
    description = "Playwright agent CLI (@playwright/cli): drive a browser via per-command terminal calls";
    mainProgram = "playwright-cli";
    homepage = "https://github.com/microsoft/playwright-cli";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
})
