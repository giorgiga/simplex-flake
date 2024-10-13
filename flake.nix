{

  inputs.nixpkgs = {
    url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, ... }@inputs: {

    packages =
    let
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      callPackage = pkgs.callPackage;
    in {
      "x86_64-linux" = {
        simplex-chat         = callPackage ./pkgs/by-name/si/simplex-chat/package.nix { };
        simplex-ntf-server   = callPackage ./pkgs/by-name/si/simplex-ntf-server/package.nix { };
        simplex-smp-server   = callPackage ./pkgs/by-name/si/simplex-smp-server/package.nix { };
        simplex-xftp         = callPackage ./pkgs/by-name/si/simplex-xftp/package.nix { };
        simplex-xftp-server  = callPackage ./pkgs/by-name/si/simplex-xftp-server/package.nix  { };
      };
    };

    nixosModules.default = import ./nixos/modules/services/networking/simplex-chat.nix;

  };

}
