# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Use linux-zen
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 20;
  boot.loader = {
    grub = {
      # efiInstallAsRemovable = true;
      enable = true;
      version = 2;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 5;
    };
  };

  # Networking
  networking.hostName = "saltlake"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Time Zone
  time.hardwareClockInLocalTime = true;
  time.timeZone = "Asia/Kolkata";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Sound 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
  };

  # Qtile
  services.xserver.windowManager.qtile.enable = true;

  # User
  users.users.blucin = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "networkmanager" "lp" "scanner" "storage"];
  };

  # Enable Flakes Permanently
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     firefox
  ];

  system.stateVersion = "23.05";  

}

