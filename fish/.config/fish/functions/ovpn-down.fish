function ovpn-down
    if not pgrep -f "openvpn --config /root/vop/client.conf" > /dev/null
        echo "OpenVPN not running"
        return
    end

    sudo pkill -f "openvpn --config /root/vop/client.conf"
    echo "OpenVPN stopped"
end
