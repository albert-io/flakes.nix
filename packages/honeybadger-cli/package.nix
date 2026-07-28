{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
}:

buildGoModule rec {
  pname = "honeybadger-cli";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "cli";
    tag = "v${version}";
    hash = "sha256-Qr8T40UgwViiOjfmnGZlvTUT4L7gV+fLJy8DWSMaVC0=";
  };

  nativeBuildInputs = [ installShellFiles ];

  subPackages = [ "cmd/hb" ];

  vendorHash = "sha256-CdYt41J9TAQ93s65ZAX+hQjeZKJEkzvYEVZNKfpuF30=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/honeybadger-io/cli/cmd.Version=${version}"
  ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd hb \
      --bash <($out/bin/hb completion bash) \
      --fish <($out/bin/hb completion fish) \
      --zsh <($out/bin/hb completion zsh)
  '';

  meta = {
    description = "Official command line interface for the Honeybadger API";
    mainProgram = "hb";
    homepage = "https://github.com/honeybadger-io/cli";
    changelog = "https://github.com/honeybadger-io/cli/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
