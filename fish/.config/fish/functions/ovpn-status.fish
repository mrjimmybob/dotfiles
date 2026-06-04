function ovpn-status
    if pgrep -f "openvpn --config /root/vop/client.conf" > /dev/null
        echo "OpenVPN is running"
    else
        echo "OpenVPN is NOT running"
    end
end
