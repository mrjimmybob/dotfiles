function rdp-ovpn-fs

    set user "usrva36@toyota-canarias.com.es"
    set passwd "v4L2026P3r!@"

    echo "🖥️ Connecting to 172.30.254.114 ..."
    xfreerdp /u:$user /p:$passwd /v:172.30.254.114 /f +clipboard /cert:ignore
end
