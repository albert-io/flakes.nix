{
  lib,
  buildGo127Module,
  fetchFromGitHub,
}:

buildGo127Module rec {
  pname = "honeybadger-mcp-server";
  rev = "19473ae95e2d0d245024139187cfaa6312545244";
  version = "unstable-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "honeybadger-mcp-server";
    inherit rev;
    hash = "sha256-YUGGdJdQYLCYobRZg18S9PLuA4Z1iA3INLxMp5Qy8ac=";
  };

  subPackages = [ "cmd/honeybadger-mcp-server" ];

  vendorHash = "sha256-8iKIVaTMSu7USLOX1/euXBnOK+NzVIVTdA2CiuxJJ/g=";

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
