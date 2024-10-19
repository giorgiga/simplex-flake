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
        # simplexmq-ntf-server   = callPackage ./pkgs/servers/simplexmq/ntf-server-package.nix { };
        simplexmq-smp-server   = callPackage ./pkgs/servers/simplexmq/smp-server-package.nix { };
        # simplexmq-xftp         = callPackage ./pkgs/servers/simplexmq/xftp-package.nix { };
        # simplexmq-xftp-server  = callPackage ./pkgs/servers/simplexmq/xftp-server-package.nix  { };
      };
    };

    # nixosModules.default = import ./nixos/modules/services/networking/simplex-chat.nix;

  };

}
