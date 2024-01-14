{

  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  
  outputs = { self, nixpkgs, home-manager, ... }@inputs:

  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};

    pkgs = import nixpkgs {
      inherit system;
      config = { 
        allowUnfree = true;
      };
    };

  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [ ./profiles/laptop/configuration.nix ];

	specialArgs = {
	  # pass config variables from above
	};

      };
    };
    

    homeConfigurations = {
      koushikhr = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
    	modules = [ ./profiles/laptop/home.nix ];
	extraSpecialArgs = {
	  # pass config variables from above
      };
    };
    };

    # homeManagerConfigurations = {
    #   koushikhr = home-manager.lib.homeManagerConfiguration {
    #     inherit system pkgs;
    # 	username = "koushikhr";
    # 	homeDirectory = "/home/koushikhr";
    # 	configuration = {
    # 	  imports = [ ./profiles/laptop/home.nix ];
    # 	};
    #   };
    # };

  };

}
