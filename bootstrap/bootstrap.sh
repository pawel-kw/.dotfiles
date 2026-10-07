#!/usr/bin/env bash
# Bootstrap the dotfiles on a fresh machine.
# - Detects macOS vs Linux.
# - Installs the package set (Homebrew/Brewfile or apt + manual installers).
# - Stows the requested packages into $HOME.
#
# Usage:
#   ./bootstrap/bootstrap.sh                # full bootstrap
#   ./bootstrap/bootstrap.sh --stow-only    # skip package install, just symlink
#   ./bootstrap/bootstrap.sh --packages-only# install packages, skip stow
#
# Idempotent: safe to re-run.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

STOW_PACKAGES=(nvim wezterm tmux zsh vim)
DO_PACKAGES=1
DO_STOW=1

for arg in "$@"; do
  case "$arg" in
    --stow-only)     DO_PACKAGES=0 ;;
    --packages-only) DO_STOW=0 ;;
    -h|--help)
      sed -n '2,15p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

bold()  { printf '\033[1m%s\033[0m\n' "$*"; }
green() { printf '\033[32m%s\033[0m\n' "$*"; }
warn()  { printf '\033[33m%s\033[0m\n' "$*" >&2; }

OS="$(uname -s)"

install_packages_macos() {
  bold "==> Installing macOS packages via Homebrew"
  if ! command -v brew >/dev/null 2>&1; then
    bold "    Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew bundle --file="$REPO_ROOT/bootstrap/Brewfile"
}

install_packages_linux() {
  bold "==> Installing Linux packages via apt"
  if ! command -v apt-get >/dev/null 2>&1; then
    warn "    Non-Debian Linux detected. Install equivalents of bootstrap/packages-linux.txt manually."
    return 0
  fi
  sudo apt-get update
  # shellcheck disable=SC2046
  sudo apt-get install -y $(grep -vE '^\s*(#|$)' "$REPO_ROOT/bootstrap/packages-linux.txt")

  bold "==> Linux extras (neovim>=0.10, lazygit, uv, sqlfluff)"
  # Neovim: distro packages are usually too old. Use the official appimage or PPA.
  if ! command -v nvim >/dev/null 2>&1 || ! nvim --version | head -1 | grep -qE 'NVIM v0\.(1[0-9]|[2-9][0-9])'; then
    warn "    Install Neovim >= 0.10 manually: https://github.com/neovim/neovim/releases"
  fi
  command -v uv >/dev/null 2>&1 || curl -LsSf https://astral.sh/uv/install.sh | sh
  command -v sqlfluff >/dev/null 2>&1 || pipx install sqlfluff || pip3 install --user sqlfluff
  command -v lazygit >/dev/null 2>&1 || warn "    lazygit: see https://github.com/jesseduffield/lazygit#installation"
  command -v terraform >/dev/null 2>&1 || warn "    terraform: see https://developer.hashicorp.com/terraform/install"
  command -v wezterm >/dev/null 2>&1 || warn "    wezterm: see https://wezfurlong.org/wezterm/install/linux.html"
}

stow_packages() {
  bold "==> Stowing packages into \$HOME"
  if ! command -v stow >/dev/null 2>&1; then
    warn "stow is not installed. Install it first or run this script with package install enabled."
    exit 1
  fi
  mkdir -p "$HOME/.config"
  for pkg in "${STOW_PACKAGES[@]}"; do
    if [[ ! -d "$REPO_ROOT/$pkg" ]]; then
      warn "    skip: package '$pkg' missing from repo"
      continue
    fi
    bold "    -> $pkg"
    stow --target="$HOME" --restow --verbose=1 "$pkg" || {
      warn "    stow failed for '$pkg'. Resolve conflicts (move existing files aside) and re-run."
      exit 1
    }
  done
  green "✓ Stow complete."
}

copy_templates() {
  # Files that should NOT be symlinks (user-editable, machine-local).
  # Copy the in-repo template only if no file exists in $HOME yet.
  bold "==> Seeding user-editable templates (no overwrite)"
  local src="$REPO_ROOT/tmux/.tmux.conf.local"
  local dst="$HOME/.tmux.conf.local"
  if [[ -f "$src" && ! -e "$dst" ]]; then
    cp -v "$src" "$dst"
  else
    echo "    ~/.tmux.conf.local already exists — leaving it alone."
  fi
}

install_wezterm_terminfo() {
  # The 'wezterm' terminfo entry is required for correct backspace/delete/arrow
  # key escape sequences and undercurl support when wezterm.lua sets
  # `config.term = 'wezterm'`. macOS doesn't ship it; install once into
  # ~/.terminfo so any program that reads $TERM=wezterm finds it.
  bold "==> Ensuring 'wezterm' terminfo is installed"
  if infocmp wezterm >/dev/null 2>&1; then
    echo "    already present — skipping."
    return 0
  fi
  if ! command -v tic >/dev/null 2>&1; then
    warn "    'tic' (ncurses) not found; cannot install terminfo. Skipping."
    return 0
  fi
  local tmp
  tmp="$(mktemp)"
  if curl -fsSL -o "$tmp" \
       https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo; then
    tic -x -o "$HOME/.terminfo" "$tmp" && echo "    installed to ~/.terminfo"
  else
    warn "    failed to download wezterm.terminfo (no network?). Skipping."
  fi
  rm -f "$tmp"
}

post_install_hints() {
  bold "==> Next steps"
  cat <<EOF
  • Open Neovim ('nvim') — lazy.nvim will fetch plugins on first launch, then run :Mason
    to verify language servers + formatters are installed.
  • For Snowflake querying via :DBUI, install the python driver:
      uv pip install --system snowflake-connector-python snowflake-sqlalchemy
    (or in a venv) and add a connection in :DBUIAddConnection.
  • Reload your shell so the new \$PATH (uv, pyenv, etc.) takes effect.
EOF
}

if [[ $DO_PACKAGES -eq 1 ]]; then
  case "$OS" in
    Darwin) install_packages_macos ;;
    Linux)  install_packages_linux ;;
    *)      warn "Unsupported OS: $OS. Skipping package install." ;;
  esac
fi

if [[ $DO_STOW -eq 1 ]]; then
  stow_packages
  copy_templates
  install_wezterm_terminfo
fi

post_install_hints
green "Done."
