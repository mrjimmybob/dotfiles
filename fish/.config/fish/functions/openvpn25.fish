function openvpn25
    nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-22.11.tar.gz -p openvpn --run "openvpn $argv"
end
