{
  description = "spread development shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      runtimeLibs = with pkgs; [
        libxcb
        libxkbcommon
        wayland
        vulkan-loader
        stdenv.cc.cc
      ];
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath runtimeLibs;
      };
    };
}
