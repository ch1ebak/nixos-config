{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      modules = [
      ./configuration.nix
      inputs.mangowm.nixosModules.mango
      ];
    };
  };
}

