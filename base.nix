{ config, lib, pkgs, modulesPath, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./home/jtremesay/base.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };
  environment.systemPackages = with pkgs; [
    bind
    curl
    httpie
    jq
    nixfmt
    psmisc
    python3Full
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  networking = {
    domain = "slaanesh.org";
    nameservers =
      [ "9.9.9.9" "149.112.122.122" "[2620:fe::fe]" "[2620:fe::9]" ];
    networkmanager.enable = true;
    search = [ config.networking.domain ];
    firewall.enable = false;
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  programs = {
    fish.enable = true;
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    tmux.enable = true;
  };
  security.sudo.wheelNeedsPassword = false;
  services = {
    fwupd.enable = true;
    locate = {
      enable = true;
      interval = "hourly";
    };
    openssh = {
      enable = true;
      startWhenNeeded = true;
      kbdInteractiveAuthentication = false;
      passwordAuthentication = false;
    };
    resolved.enable = true;
  };
  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "22.05"; # Did you read the comment?

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    copySystemConfiguration = true;
  };
  time.timeZone = "Europe/Paris";
  users.users.jtremesay = {
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  users.extraUsers.jtremesay = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2QfuCeW4Pv+fZnlukbg844Z2P67m4ImBvdyNL7bPXdxH1FoAlWEbZpTvvZPXWNzHnrAQ63GEN07a0bzlbzG0ut/xHKBx/ltZcjcNQkQGB5ta2mewfKCQM/nAA2VdhwbZCa5VGJyCq3oj9HKaJ5RTHsSOSIvh7FQRbM/uAKUZHtfLzd7jBWwuyB/VSB1qSEO4yCHtYjvO4eEjur86fZNe+pHsejtuFN5HMh5QVMeud0VmbeB93L3M2die76u0Nd/Ea9q7/FkR4xR8a9OXAmp7PmCoB7/UlKufh6KvGeHE8xKl8Pibf/cpR56ViRvav660+TREQ9uxoi81S9r4qCOUUEEsuAIaVmGTsKeZ1zSWG3PGwTtIgMOxpCXF1FhSHcIvMh4JNkykzdG6Ul76kDEw6Tdc2cE6uA+o7jnVo3TDrSM5ZYE1ZrRlCz1SWRspx04GUxrjWNTd3wkiAx6vliKMM9/2FdzZRgDk4hlbQgoi1jO7TK/KZQKTaWBbIyTDgGNXQZjhM5fwW2LrmLymD6OXJo4qGLZwD51X+TX0JJZrxmUlsTNQE852o0snEl/rqojsp0+dn3x3Zti868kINTNF0PNcO/HgqwLqk67K3JcFlJNV+sVshUtW7gjHaqZ+Fpe4vV5mECQ2qrSw/ulr8EmeMaPsve9hltE2qnYSZaQSq0Q== killruana@edemaruh.slaanesh.org"
    ];
  };
}
