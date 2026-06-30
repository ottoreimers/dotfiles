[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# Ensure cargo-installed binaries (e.g. tree-sitter CLI) are on PATH even
# when ~/.cargo/env is absent.
case ":$PATH:" in
  *":$HOME/.cargo/bin:"*) ;;
  *) export PATH="$HOME/.cargo/bin:$PATH" ;;
esac
