{ inputs =
    { circom.url = "github:Polytopoi/circom/nix";
      flake-utils.url = "github:numtide/flake-utils";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

  outputs = { circom, flake-utils, nixpkgs, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
            circom-out = circom.defaultPackage.${system};
        in
        {
          devShells.default =
            pkgs.mkShell {
              buildInputs = [ circom-out pkgs.nodejs-19_x ];
            };
        }
      );
}
