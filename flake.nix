{

	description = "My first flake";
	
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs =  { self, home-manager, nixpkgs, ... }:
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		nixosConfigurations = {
			nisys = lib.nixosSystem {
				inherit system; 
				modules = [ ./configuration.nix ];
			};
		};
		homeConfigurations = {
			ni = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
				  ./home.nix
				];
			};
		};
	};

}
