#!/usr/bin/env bash
# Remove all symlinks created by bootstrap.sh / stow.
# Does NOT touch ~/.config/nvim/{lazy-lock.json,plugin/} or other generated files
# beyond the symlinks themselves.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

STOW_PACKAGES=(nvim wezterm tmux zsh vim)

if ! command -v stow >/dev/null 2>&1; then
  echo "stow is not installed; nothing to do." >&2
  exit 1
fi

echo "==> Unstowing packages from \$HOME"
for pkg in "${STOW_PACKAGES[@]}"; do
  if [[ -d "$REPO_ROOT/$pkg" ]]; then
    echo "    -> $pkg"
    stow --target="$HOME" --delete --verbose=1 "$pkg" || true
  fi
done

echo "Done. Plugin caches at ~/.local/share/nvim, ~/.cache/nvim, ~/.local/state/nvim are untouched."
