function stowify --description "Move configs into dotfiles repo and stow them"
    set dotroot "$HOME/Development/dotfiles"

    if test (count $argv) -eq 0
        echo "Usage: stowify <config> [config ...]"
        echo
        echo "Examples:"
        echo "  stowify niri"
        echo "  stowify niri noctalia quickshell"
        echo
        echo "Dependencies:"
        echo "  dotfile directory must exist: $dotroot"
        return 1
    end

    for app in $argv
        set src "$HOME/.config/$app"
        set pkg "$dotroot/$app"
        set dst "$pkg/.config/$app"

        echo "Processing config file $argv"
        if not test -d "$src"
            echo "Skipping $app: $src not found"
            continue
        end

        if test -e "$dst"
            echo "Skipping $app: $dst already exists"
            continue
        end

        mkdir -p "$pkg/.config"

        echo "Moving $src -> $dst"
        mv "$src" "$dst"

        echo "Stowing $app"
        command stow -d "$dotroot" -t "$HOME" "$app"

        echo "Done: $app"
        echo
    end
end
