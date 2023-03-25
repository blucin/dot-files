{
  description = "Blucin's ( rightfully stolen + own :) ) configurations";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
       system = "x86_64-linux";
       pkgs = import nixpkgs {
         inherit system;
         config.allowUnfree = true;
       };
       #pkgs = nixpkgs.legacyPackages.${system};
       lib = nixpkgs.lib;
    in {
       nixosConfigurations = {
         blucin = lib.nixosSystem {
           inherit system;
           modules = [
            ./configuration.nix 
           ];
         };
       };

       homeConfigurations = {
          blucin = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ 
		./home.nix 
		{
		  home = {
			username = "blucin";
			homeDirectory = "/home/blucin";
			stateVersion = "22.11";
		  };
		}	
	     ];
          };
       };
    };
}

