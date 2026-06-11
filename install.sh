#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --file=Brewfile

# Symlink configs into $HOME.
# tmux and karabiner keep real dirs (runtime state lives next to config),
# so stow links their files individually instead of the whole dir.
mkdir -p "$HOME/.config/tmux" "$HOME/.config/karabiner"
stow --target="$HOME" --restow nvim zsh git tmux starship ghostty kitty karabiner sketchybar

# tmux plugin manager (plugins are not tracked; tpm installs them with prefix+I)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
fi

echo "Done. Open tmux and press prefix+I to install tmux plugins."
