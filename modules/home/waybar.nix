{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        programs.waybar = {
            enable = true;
            style = ''
                * {
                    font-size: 16px;
                    font-family: MesloLGS Nerd Font;
                }

                window#waybar {
                    background: #292b2e;
                    color: #fdf6e3;
                }

                #custom-right-arrow-dark,
                #custom-left-arrow-dark {
                    font-size: 20px;
                    color: #1a1a1a;
                }
                #custom-right-arrow-light,
                #custom-left-arrow-light {
                    font-size: 20px;
                    color: #292b2e;
                    background: #1a1a1a;
                }

                #workspaces,
                #scratchpad,
                #network,
                #custom-ping,
                #clock.1,
                #clock.2,
                #clock.3,
                #pulseaudio,
                #memory,
                #cpu,
                #battery,
                #disk,
                #tray {
                    background: #1a1a1a;
                }

                #workspaces button {
                    padding: 0 2px;
                    color: #fdf6e3;
                }
                #workspaces button.focused {
                    color: #268bd2;
                }
                #workspaces button:hover {
                    box-shadow: inherit;
                    text-shadow: inherit;
                }
                #workspaces button:hover {
                    background: #1a1a1a;
                    border: #1a1a1a;
                    padding: 0 3px;
                }

                #pulseaudio {
                    color: #268bd2;
                }
                #memory {
                    color: #2aa198;
                }
                #cpu {
                    color: #6c71c4;
                }
                #battery {
                    color: #859900;
                }
                #disk {
                    color: #b58900;
                }

                #clock,
                #network,
                #custom-ping,
                #pulseaudio,
                #memory,
                #cpu,
                #battery,
                #disk {
                    padding: 0 10px;
                }
            '';
            settings = {
                default = {
                    "layer" = "top";
                    "position"= "top";

                    "modules-left"= [
                        "sway/workspaces"
                        "sway/scratchpad"
                        "custom/right-arrow-dark"
                        "custom/right-arrow-light"
                        "network"
                        # "custom/ping"
                        "custom/right-arrow-dark"
                    ];
                    "modules-center"= [
                        "custom/left-arrow-dark"
                        "clock#1"
                        "custom/left-arrow-light"
                        "custom/left-arrow-dark"
                        "clock#2"
                        "custom/right-arrow-dark"
                        "custom/right-arrow-light"
                        "clock#3"
                        "custom/right-arrow-dark"
                    ];
                    "modules-right"= [
                        "custom/left-arrow-dark"
                        "pulseaudio"
                        "custom/left-arrow-light"
                        "custom/left-arrow-dark"
                        "memory"
                        "custom/left-arrow-light"
                        "custom/left-arrow-dark"
                        "cpu"
                        "custom/left-arrow-light"
                        "custom/left-arrow-dark"
                        "battery"
                        "custom/left-arrow-light"
                        "custom/left-arrow-dark"
                        "disk"
                    ];

                    "custom/left-arrow-dark"= {
                        "format"= "";
                        "tooltip"= false;
                    };
                    "custom/left-arrow-light"= {
                        "format"= "";
                        "tooltip"= false;
                    };
                    "custom/right-arrow-dark"= {
                        "format"= "";
                        "tooltip"= false;
                    };
                    "custom/right-arrow-light"= {
                        "format"= "";
                        "tooltip"= false;
                    };

                    "sway/workspaces"= {
                        "disable-scroll"= true;
                        "format"= "{name}";
                    };

                    "sway/scratchpad"= {
                        "format"= "{icon} {count}";
                        "show-empty"= false;
                        "format-icons"= ["" ""];
                        "tooltip"= true;
                        "tooltip-format"= "{app}: {title}";
                    };

                    "network" = {
                        "interval" = 5;
                        "format" = "{iwname}";
                        "format-wifi" = "{essid} ({signalStrength}%)";
                        "format-ethernet" = "{ipaddr}";
                        "format-disconnected" = "Disconnected";
                        "format-disabled" = "Disabled";
                        "tooltip-format" = "{ipaddr}\n({bandwidthDownBytes}   {bandwidthUpBytes})";
                        "on-click" = "foot -e sh -c \"sleep 0.1 && nmtui\"";
                    };

                    "custom/ping" = {
                        "interval" = 5;
                        "exec" = "ping 1.1 -c 1 | grep -oP '(?<=\=)[0-9]*\.?[0-9]* ms'";
                    };

                    "clock#1"= {
                        "format"= "{:%A}";
                        "tooltip"= false;
                    };
                    "clock#2"= {
                        "interval"= 1;
                        "format"= "{:%H:%M:%S}";
                        "tooltip"= false;
                    };
                    "clock#3"= {
                        "format"= "{:%Y-%m-%d}";
                        "tooltip"= false;
                        "on-click" = "exec date +%F | wl-copy";
                    };

                    "pulseaudio"= {
                        "format"= "{icon} {volume:2}%";
                        "format-bluetooth"= "{icon}  {volume}%";
                        "format-muted"= "MUTE";
                        "format-icons"= {
                            "headphones"= "";
                            "default"= [
                                ""
                                ""
                            ];
                        };
                        "scroll-step"= 5;
                        "on-click"= "pavucontrol";
                    };
                    "memory"= {
                        "interval"= 5;
                        "format"= "  {}%";
                    };
                    "cpu"= {
                        "interval"= 5;
                        "format"= "  {usage:2}%";
                        "on-click"= "foot -e htop";
                    };
                    "battery"= {
                        "states"= {
                            "good"= 95;
                            "warning"= 30;
                            "critical"= 15;
                        };
                        "format"= "{icon}  {capacity}%";
                        "format-charging" = "  {capacity}%";
                        "format-icons"= [
                            ""
                            ""
                            ""
                            ""
                            ""
                        ];
                    };
                    "disk"= {
                        "interval"= 5;
                        "format"= "  {percentage_used:2}%";
                        "path"= "/";
                    };
                };
            };
        };
    };
}
