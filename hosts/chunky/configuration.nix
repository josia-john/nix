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

  security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        extraConfig.pipewire = {
            "ROC" = {                     # Note that roc-source needs to be linked to some output!! See man pw-link.
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
        { from = 10001; to = 10003; } # ROC
        { from = 7000; to = 7002; } # uxplay
      ];
      allowedUDPPortRanges = [
        { from = 10001; to = 10003; } # ROC
        { from = 7000; to = 7002; } # uxplay
      ];
    };
    services.cron = {
    enable = true;
        # pw-link roc-sink:receive_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL??
        systemCronJobs = [
        "0 0 * * * josia bash -c 'export XDG_RUNTIME_DIR=/run/user/1000; pkill \"uxplay\"; sleep 2; uxplay -p 7000 -vs 0 > /tmp/uxplay.log 2>&1 &'" 
        "@reboot josia bash -c 'export XDG_RUNTIME_DIR=/run/user/1000; pkill \"uxplay\"; sleep 2; uxplay -p 7000 -vs 0 > /tmp/uxplay.log 2>&1 &'" 
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