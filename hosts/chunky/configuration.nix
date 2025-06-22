# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "chunky"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure console keymap
  console.keyMap = "dvorak";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.josia = {
    isNormalUser = true;
    description = "josia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    git
    uxplay
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
          enable = true;
          userServices = true;
          addresses = true;
      };
  };
  
  services.openssh = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
    group = "users";
    user = "josia";
    dataDir = "/home/josia/Documents";      # Won't be used... Hopefully
    configDir = "/home/josia/Documents/.config/syncthing";
    openDefaultPorts = true;
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    settings = {
        devices = {
            "nixy" = { id = "Y2366NA-DI2LJ2J-7YGAFT2-PB7JCAZ-HVELDIN-WOKIU22-7FLYE5Q-OXV7MQH"; };
            "phone" = { id = "OMZVZR4-WGMDJLT-YKGV7DJ-F4L6QNN-UXQQ3MZ-6QEG7QW-IYL2Q7R-WKKZGAX"; };
        };
        folders = {
            "workspace" = {         # Name of folder in Syncthing, also the folder ID
            path = "/SYNCTHING/workspace";    # Which folder to add to Syncthing
            devices = [ "nixy" "phone" ];      # Which devices to share the folder with
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600"; # 1 hour
                maxAge = "31536000";    # 1 year
              };
            };
            };
        };
    };
  };

  security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        extraConfig.pipewire = {
            "ROC" = {
            "context.modules" = [
                {
                    name = "libpipewire-module-roc-source";
                    args = {
                        "fec.code" = "disable"; # Replace with your desired multicast or unicast IP
                        "local.ip" = "0.0.0.0";
                        "local.source.port" = 10001;
                        "local.repair.port" = 10002;
                        "local.control.port" = 10003;
                        "sess.latency.msec" = 100;
                        "source.name" = "roc-sink";
                        "source.props" = {
                            "node.name" = "roc-sink";
                            "node.description" = "ROC Sink";
                            "media.class" = "Audio/Source";
                        };
                    };
                }
            ];
            };
        };
    };
    networking.firewall = {
      allowedTCPPortRanges = [
        { from = 10001; to = 10009; } # ROC
      ];
      allowedUDPPortRanges = [
        { from = 10001; to = 10009; } # ROC
      ];
    };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
