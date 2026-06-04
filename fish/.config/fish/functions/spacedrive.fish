function spacedrive --description 'Run Spacedrive wrapped with Wayland compatibility flags'
    GDK_BACKEND=x11 WEBKIT_DISABLE_COMPOSITING_MODE=1 command spacedrive $argv &
    disown
end
