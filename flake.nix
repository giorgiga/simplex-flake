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
        simplex-chat           = callPackage ./pkgs/by-name/si/simplex-chat/package.nix { };
        simplexmq-ntf-server   = callPackage ./pkgs/by-name/si/simplexmq-ntf-server/package.nix { };
        simplexmq-smp-server   = callPackage ./pkgs/by-name/si/simplexmq-smp-server/package.nix { };
        simplexmq-xftp         = callPackage ./pkgs/by-name/si/simplexmq-xftp/package.nix { };
        simplexmq-xftp-server  = callPackage ./pkgs/by-name/si/simplexmq-xftp-server/package.nix  { };
      };
    };

    nixosModules.default = import ./nixos/modules/services/networking/simplex-chat.nix;

  };

}
