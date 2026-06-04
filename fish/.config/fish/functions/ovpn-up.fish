function ovpn-up
    if pgrep -f "openvpn --config /home/dallas/vop/client.conf" > /dev/null
        echo "OpenVPN already running"
        return
    end

    sudo nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-22.11.tar.gz -p openvpn --run "openvpn --config /home/dallas/vop/client.conf --daemon"
    echo "OpenVPN started"
end
