{

  inputs.nixpkgs = {
    url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, ... }@inputs: {

    packages =
    let
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      callPackage = pkgs.callPackage;
      revisions = { revisions = import ./pkgs/servers/simplexmq/revisions.nix; };
    in {
      "x86_64-linux" = {
        simplexmq-smp-server = callPackage ./pkgs/servers/simplexmq/smp-server-package.nix revisions;

        simplexmq-aeson            = callPackage ./pkgs/servers/simplexmq/aeson.nix revisions;
        simplexmq-attoparsec-aeson = callPackage ./pkgs/servers/simplexmq/attoparsec-aeson.nix revisions;
      };
    };

    # nixosModules.default = import ./nixos/modules/services/networking/simplex-chat.nix;

  };

}
