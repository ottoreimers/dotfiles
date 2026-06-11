# dotfiles

My macOS setup, managed with [GNU stow](https://www.gnu.org/software/stow/).

## New machine

```sh
git clone https://github.com/ottoreimers/dotfiles ~/dotfiles
cd ~/dotfiles && ./install.sh
```

That installs Homebrew (if missing), everything in the `Brewfile`, and symlinks
all configs into `$HOME`.

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
