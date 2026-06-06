fish_add_path ~/.npm-global/bin

if status is-interactive

    # Set up path
    if status is-login
        contains ~/.config/emacs/bin $PATH
        or set PATH ~/.config/emacs/bin $PATH
    end

    # Commands to run in interactive sessions can go here
    set fish_greeting "🐟"
    fastfetch
    fortune -a true

    # Set up some environment variables
    set -gx EDITOR nvim
    set -x LD_LIBRARY_PATH /run/opengl-driver/lib:/run/current-system/sw/lib $LD_LIBRARY_PATH

    # Set up some aliases
    alias ls="eza --icons"
    alias la="eza -la --icons"
    alias ll="eza -l --icons"
    alias cd="z"

    # SSH Agent: Automatic start
    # Start ssh-agent if not already running (Not needed if using gnome keyring or kwallet)
    #if not pgrep -u (whoami) ssh-agent >/dev/null
    #    eval (ssh-agent -c)
    #end

    # Add SSH key if not already added
    # ssh-add -l >/dev/null 2>&1
    # or
    ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1

    # Tmux
    eval (tmuxifier init - fish)

    # Set up zoxide
    zoxide init fish | source

    # Set up carapace
    set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
    # This takes too long, just run it once
    # mkdir -p ~/.config/fish/completions
    # carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#186)
    carapace _carapace | source

    # Set up Starfish
    source (/run/current-system/sw/bin/starship init fish --print-full-init | psub)
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/dallas/.lmstudio/bin
# End of LM Studio CLI section
