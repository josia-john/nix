{ config, lib, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --remember --asterisks --cmd 'sway'";
      };
    };
  };
}