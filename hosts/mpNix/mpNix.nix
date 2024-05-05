####### Special Config mpNix.nix #######

{ config, inputs, lib, modulesPath, ... }:

{
  imports = [
      ./mphardware.nix
      inputs.disko.nixosModules.default
        (import ./mpdisko.nix { device = "/dev/sda"; })  
      ../../base.nix
    ];

  # Variables
    environment.variables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5"; # Effects Obsidian & Vivaldi
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "96"; # Also added Xft.dpi: 192 to .Xresources in ~
    };
    
    networking.hostName = "mpNix";
    
    services.xserver = {
      dpi = 288;
      upscaleDefaultCursor = true;
    };
    
    services.mbpfan.enable = true;
    services.fstrim.enable = true;
}
