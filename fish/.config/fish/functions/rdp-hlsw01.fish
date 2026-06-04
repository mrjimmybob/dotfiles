function rdp-hlsw01

    set user Administrator
    set passwd "10pcisaJoke!"

    echo "🖥️ Connecting to HLSW01 ..."
    xfreerdp /u:$user /p:$passwd /v:192.168.1.225 /size:3840x1440 +clipboard /cert:ignore
end
