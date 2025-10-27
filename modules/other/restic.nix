{ config, lib, pkgs, ... }:
{
    services.restic.backups = {
        chunky = {
            paths = ["/home/josia/workspace"];
            repository = "sftp:josia@10.8.100.239:Backups/BackupsNixy";
            initialize = true;
            extraOptions = [
                "sftp.args='-i /home/josia/.ssh/id_ed25519'"
            ];
            timerConfig = {
                OnCalendar = "daily";
                Persistent = true;
                RandomizedDelaySec = "3h";
            };
            passwordFile = "/home/josia/restic_password_nixy_on_chunky";
        };
        hetzner = {
            paths = ["/home/josia/workspace"];
            repository = "sftp:u502956-sub1@u502956-sub1.your-storagebox.de:";
            initialize = true;
            extraOptions = [
                "sftp.args='-i /home/josia/.ssh/id_ed25519'"
            ];
            timerConfig = {
                OnCalendar = "daily";
                Persistent = true;
                RandomizedDelaySec = "3h";
            };
            passwordFile = "/home/josia/restic_password_nixy_on_hetzner";
        };
    };
}