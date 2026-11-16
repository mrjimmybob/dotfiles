# User paths
fish_add_path ~/.npm-global/bin
fish_add_path ~/.local/bin
fish_add_path ~/.lmstudio/bin
fish_add_path ~/.kilo/bin
fish_add_path /usr/local/bin
fish_add_path ~/.config/emacs/bin

# Environment
set -gx EDITOR nvim
set -gx VISUAL nvim

if status is-interactive
    set fish_greeting "🐟"

    # Startup information
    if command -q fastfetch
        fastfetch
    end

    if command -q fortune
        fortune -a
    end

    # Aliases
    if command -q eza
        alias ls "eza --icons auto"
        alias la "eza -la --icons auto"
        alias ll "eza -l --icons auto"
    end

    # SSH key
    if set -q SSH_AUTH_SOCK
        if test -f ~/.ssh/id_ed25519
            ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
        end
    end

    # Zoxide
    if command -q zoxide
        zoxide init fish | source
        alias cd z
    end

    # Starship prompt
    if command -q starship
        starship init fish | source
    end

    # Carapace completions
    if command -q carapace
        set -gx CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
        carapace _carapace | source
    end

    # Atuin history
    if command -q atuin
        atuin init fish | source
    end

    # Ada / GNAT
    if command -q gcc
        set -l crt (gcc -print-file-name=crt1.o)
        if test -f "$crt"
            set -gx GLIBC_LIB (dirname "$crt")
        end
    end
end


# Added by Antigravity CLI installer
set -gx PATH "/home/dallas/.local/bin" $PATH
