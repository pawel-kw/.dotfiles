#!/usr/bin/env bash
# Thin wrapper that delegates to bootstrap/bootstrap.sh.
# Kept for backward compatibility with the original repo layout.
set -euo pipefail
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bootstrap/bootstrap.sh" "$@"
