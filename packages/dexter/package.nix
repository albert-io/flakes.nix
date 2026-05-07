{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
}:

buildGoModule rec {
  pname = "dexter";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "remoteoss";
    repo = "dexter";
    tag = "v${version}";
    hash = "sha256-BmWzrbC9ka8L1/mrPOXJqnoi1YVXxRcg6tSkb8tI88Q=";
  };

  nativeBuildInputs = [ installShellFiles ];

  proxyVendor = true;
  vendorHash = "sha256-1mJ4HdDCsZl/g8F+L+NrW2ACuiHe2aSheJO/1XfKAb4=";

  postInstall = ''
    mv $out/bin/cmd $out/bin/dexter
  ''
  + (lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd dexter \
      --bash <($out/bin/dexter completion bash) \
      --fish <($out/bin/dexter completion fish) \
      --zsh <($out/bin/dexter completion zsh)
  '');

  meta = {
    description = "Fast implementation of Elixir language server in Go";
    mainProgram = "dexter";
    homepage = "https://github.com/remoteoss/dexter";
    changelog = "https://github.com/remoteoss/dexter/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
