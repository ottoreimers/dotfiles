# dotfiles

My macOS setup, managed with [GNU stow](https://www.gnu.org/software/stow/).

## New machine

```sh
git clone https://github.com/ottoreimers/dotfiles ~/dotfiles
cd ~/dotfiles && ./install.sh
```

That installs Homebrew (if missing), everything in the `Brewfile`, and symlinks
all configs into `$HOME`.

## Linux (Fedora)

`install.sh` is macOS-only. On Fedora, set up just the portable packages
(tmux, nvim, starship, ghostty, kitty, global git ignore) by hand:

```sh
# Packages (ghostty comes from COPR)
sudo dnf copr enable scottames/ghostty
sudo dnf install git stow tmux neovim kitty ghostty ripgrep fd-find \
  gcc make unzip curl nodejs npm python3 python3-pip
curl -sS https://starship.rs/install.sh | sh

# Nerd Fonts used by ghostty (FiraCode) and kitty (FiraMono)
mkdir -p ~/.local/share/fonts
for f in FiraCode FiraMono; do
  curl -fLo /tmp/$f.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$f.zip
  unzip -o /tmp/$f.zip -d ~/.local/share/fonts/$f
done
fc-cache -f

# Dotfiles
git clone https://github.com/ottoreimers/dotfiles ~/dotfiles
cd ~/dotfiles
mkdir -p ~/.config/tmux   # tmux keeps plugins next to its config, so link files, not the dir
stow --target="$HOME" --ignore='\.gitconfig' git tmux nvim starship ghostty kitty
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Prompt (Fedora defaults to bash; use ~/.zshrc and `init zsh` if on zsh)
echo 'eval "$(starship init bash)"' >> ~/.bashrc
```

Then:

- **tmux**: start it and press `C-a I` to install plugins.
- **nvim**: the config needs nvim **0.12+** (`vim.pack`). If `nvim --version`
  is older, install the
  [official release tarball](https://github.com/neovim/neovim/releases)
  into `~/.local` instead. On first launch plugins install themselves and Mason
  installs the LSPs. Then run `:MasonInstall stylua prettierd black isort`
  for the formatters.
- **git**: `.gitconfig` is skipped on purpose (its signing setup points at the
  macOS 1Password app). Only the global ignore at `~/.config/git/ignore` is
  linked, which git picks up automatically.

## Layout

Each top-level directory is a stow package mirroring `$HOME`:

| Package      | What                                        |
| ------------ | ------------------------------------------- |
| `nvim`       | Neovim (vim.pack, nvim 0.12+)               |
| `zsh`        | `.zshrc`, `.zshenv`, `.zprofile`            |
| `git`        | `.gitconfig`, global ignore                 |
| `tmux`       | `tmux.conf` (plugins via tpm, not tracked)  |
| `starship`   | prompt                                      |
| `ghostty`    | terminal                                    |
| `kitty`      | terminal                                    |
| `karabiner`  | keyboard remaps                             |
| `sketchybar` | menu bar                                    |

## Editing

Configs in `$HOME` are symlinks into this repo — edit them anywhere, then
commit here. After adding new files to a package, re-run
`stow --restow <package>` from the repo root.
