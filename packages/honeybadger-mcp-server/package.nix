{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "honeybadger-mcp-server";
  rev = "179baffee49b95f7398e2154f4d8cbe6ea195e31";
  version = "unstable-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "honeybadger-mcp-server";
    inherit rev;
    hash = "sha256-ib/zbYFKU73i20IAPd1bxkXMvk701Tdsh4AV/IgdJ/0=";
  };

  subPackages = [ "cmd/honeybadger-mcp-server" ];

  vendorHash = "sha256-W7ui9bny+HGIvJRreri7zxlq2V2M0dVJwb/p1ATEfsE=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Honeybadger MCP Server";
    mainProgram = "honeybadger-mcp-server";
    homepage = "https://github.com/honeybadger-io/honeybadger-mcp-server";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
