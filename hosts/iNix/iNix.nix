####### Special Config iNix.nix #######

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./ihardware.nix
      inputs.disko.nixosModules.default
        (import ./idisko.nix { device = "/dev/sda"; })  
      ../../default.nix
    ];

    networking.hostName = "iNix";

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
