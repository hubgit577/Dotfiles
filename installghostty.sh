#!/bin/sh

set -e

DOTFILES="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

SOURCE="$DOTFILES/.config/ghostty"
DEST="$HOME/.config/ghostty"

echo "==> Installing Ghostty config"
echo "Source: $SOURCE"
echo "Destination: $DEST"
echo

if [ ! -d "$SOURCE" ]; then
    echo "Error: Ghostty config not found!"
    exit 1
fi

if [ -e "$DEST" ]; then
    mv "$DEST" "$DEST.backup"
    echo "Backup: $DEST -> $DEST.backup"
fi

mkdir -p "$(dirname "$DEST")"
cp -r "$SOURCE" "$DEST"

echo
echo "==> Ghostty config installed!"
echo "Restart Ghostty to apply the changes."