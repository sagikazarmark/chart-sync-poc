{
  description = "Chart sync PoC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (final: prev: {
              charts-syncer = prev.buildGoModule rec {
                pname = "charts-syncer";
                version = "0.20.1";

                src = prev.fetchFromGitHub {
                  owner = "bitnami-labs";
                  repo = "charts-syncer";
                  rev = "v${version}";
                  sha256 = "sha256-AGwp42dIy711iLWcuity7HRYNKQXOjrKGgFpz2gBnEc=";
                };

                vendorSha256 = "sha256-b8lYPyhovNWPZlb7JLng9ypMcFy0dYu4bd7gZRkxmEc=";


                subPackages = [ "." ];

                nativeBuildInputs = [
                  prev.installShellFiles
                ];

                postInstall = ''
                  installShellCompletion --cmd charts-syncer \
                    --bash <($out/bin/charts-syncer completion bash) \
                    --zsh <($out/bin/charts-syncer completion zsh)
                '';
              };
            })
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            charts-syncer
          ];
        };
      });
}
