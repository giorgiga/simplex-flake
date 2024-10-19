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
        simplexmq-smp-server = callPackage ./pkgs/servers/simplexmq/smp-server.nix revisions;

        simplexmq-aeson             = callPackage ./pkgs/servers/simplexmq/dependencies/aeson.nix revisions;
        simplexmq-aeson-pretty      = callPackage ./pkgs/servers/simplexmq/dependencies/aeson-pretty.nix revisions;
        simplexmq-ansi-terminal     = callPackage ./pkgs/servers/simplexmq/dependencies/ansi-terminal.nix revisions;
        simplexmq-attoparsec-aeson  = callPackage ./pkgs/servers/simplexmq/dependencies/attoparsec-aeson.nix revisions;
        simplexmq-constraints       = callPackage ./pkgs/servers/simplexmq/dependencies/constraints.nix revisions;
        simplexmq-direct-sqlcipher  = callPackage ./pkgs/servers/simplexmq/dependencies/direct-sqlcipher.nix revisions;
        simplexmq-http2             = callPackage ./pkgs/servers/simplexmq/dependencies/http2.nix revisions;
        simplexmq-ini               = callPackage ./pkgs/servers/simplexmq/dependencies/ini.nix revisions;
        simplexmq-network-transport = callPackage ./pkgs/servers/simplexmq/dependencies/network-transport.nix revisions;
        simplexmq-socks             = callPackage ./pkgs/servers/simplexmq/dependencies/socks.nix revisions;
        simplexmq-sqlcipher-simple  = callPackage ./pkgs/servers/simplexmq/dependencies/sqlcipher-simple.nix revisions;
        simplexmq-transformers      = callPackage ./pkgs/servers/simplexmq/dependencies/transformers.nix revisions;
      };
    };

    # nixosModules.default = import ./nixos/modules/services/networking/simplex-chat.nix;

  };

}
