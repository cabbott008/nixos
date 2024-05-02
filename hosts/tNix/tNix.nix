####### Special Config tNix.nix #######

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./thardware.nix
      inputs.disko.nixosModules.default
        (import ./tdisko.nix { device = "/dev/sda"; })  
      ../../base.nix
    ];

    networking.hostName = "tNix";

  # Define additional user accounts. 
    users.users.ct = {
      isNormalUser = true;
      extraGroups = [ "networkManager" ]; 
    };

    users.users.wa = {
      isNormalUser = true;
      extraGroups = [ "networkManager" ]; 
    };

  # Variables
#   environment.variables = {
#   };
}
