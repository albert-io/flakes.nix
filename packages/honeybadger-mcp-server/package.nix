{
  lib,
  buildGo127Module,
  fetchFromGitHub,
}:

buildGo127Module rec {
  pname = "honeybadger-mcp-server";
  rev = "161f6f9e6becc177e631630dd06f46898f5d1514";
  version = "unstable-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "honeybadger-mcp-server";
    inherit rev;
    hash = "sha256-eDqrFzcCnx2dIkXz3lJx+WEIe6sT7IoYL8apKvipFps=";
  };

  subPackages = [ "cmd/honeybadger-mcp-server" ];

  vendorHash = "sha256-EQMPOxtezSkNppWphE1scVbFsBrnwwLbCWQXJ+PA5dw=";

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
