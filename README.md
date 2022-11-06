# My nixos config

## Bootstrapping

```
# cd /etc
# mv /etc/nixos{,.bak}
# git clone https://github.com/killruana/nixos-config.git nixos
# cd nixos
# cp ../nixos.bak/hardware-configuration.nix .
# ln -s machines/<machine>.nix configuration.nix
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
# nix-channel --update
# nixos-rebuild switch --upgrade
# passwd jtremesay
# chown -R jtremesay .
```