function rdp-ts
    set host $argv[1]
    set default_host etf00686

    # Default to work PC if no argument
    if test -z "$host"
        set host $default_host
    end

    if not tailscale status >/dev/null 2>&1
        echo "🔌 Starting Tailscale..."
        tailscale up
    end

    switch $host
        case etf00686
            set user "usrva36@toyota-canarias.com.es"
            set passwd "v4L2026P3r!@"
        case ssna03
            set user "operador@toyota-canarias.com.es"
            set passwd toywx25ota
        case '*'
            echo "Unknown host"
            return 1
    end

    echo "🖥️ Connecting to 100.121.25.16 ..."
    xfreerdp /u:$user /p:$passwd /v:$host /size:3840x1440 +clipboard /cert:ignore
end
