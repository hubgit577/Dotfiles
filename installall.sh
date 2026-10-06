#!/bin/sh

set -e

DOTFILES="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

echo "==> Installing dotfiles"
echo "Repository: $DOTFILES"
echo

backup() {
    if [ -e "$1" ]; then
        mv "$1" "$1.backup"
        echo "Backup: $1 -> $1.backup"
    fi
}

install_dir() {
    SOURCE="$DOTFILES/$1"
    DEST="$HOME/$1"

    if [ ! -d "$SOURCE" ]; then
        echo "Skipping $1 (not found)"
        return
    fi

    if [ -e "$DEST" ]; then
        backup "$DEST"
    fi

    mkdir -p "$(dirname "$DEST")"
    cp -r "$SOURCE" "$DEST"

    echo "Installed: $1"
}

install_contents() {
    SOURCE="$DOTFILES/$1"
    DEST="$HOME/$1"

    if [ ! -d "$SOURCE" ]; then
        echo "Skipping $1 (not found)"
        return
    fi

    mkdir -p "$DEST"

    for item in "$SOURCE"/*; do
        name="$(basename "$item")"

        if [ -e "$DEST/$name" ]; then
            backup "$DEST/$name"
        fi

        cp -r "$item" "$DEST/$name"

        echo "Installed: $1/$name"
    done
}

echo "==> Installing .config files"
install_dir ".config/fastfetch"
install_dir ".config/ghostty"
install_dir ".config/rofi"
install_dir ".config/xfce4"

echo
echo "==> Installing themes and icons"
install_contents ".local/share/themes"
install_contents ".local/share/icons"

echo
echo "==> Done!"
echo "Restart your session if necessary."