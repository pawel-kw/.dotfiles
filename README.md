# .dotfiles

Personal cross-platform dotfiles, organized as **GNU Stow** packages so each
tool's config can be linked into `$HOME` independently.

Tailored for data engineering: Neovim as an IDE for **dbt**, **Terraform/sfyaml**,
**Snowflake/SQL**, **Python**, **YAML**, **Airflow**.

## Layout

| Package    | Linked to                       | What's inside                                       |
|------------|---------------------------------|-----------------------------------------------------|
| `nvim/`    | `~/.config/nvim/`               | Neovim config (kickstart-style, `lua/custom/plugins`) |
| `wezterm/` | `~/.config/wezterm/`            | WezTerm terminal config (Tokyo Night + Nerd Font)   |
| `tmux/`    | `~/.tmux.conf`, `~/.tmux.conf.local` | gpakosz tmux                                  |
| `zsh/`     | `~/.zshrc`                      | oh-my-zsh + agnoster                                |
| `vim/`     | `~/.vimrc`, `~/.vim/`           | Plain Vim config — kept as SSH/server fallback      |

`bootstrap/` is **not** a stow package — it holds the cross-platform installer
(`bootstrap.sh`), the macOS `Brewfile`, and a Linux package list.

`vendor/` holds upstream third-party files (e.g. gpakosz tmux LICENSE/README)
that should not be symlinked into `$HOME`.

## Quick start

```bash
git clone <this-repo> ~/Git/.dotfiles
cd ~/Git/.dotfiles
./bootstrap/bootstrap.sh
```

This will:

1. Install Homebrew (macOS) or apt packages (Linux) — see `bootstrap/Brewfile`
   and `bootstrap/packages-linux.txt`.
2. Install a Nerd Font, WezTerm, Neovim ≥ 0.10, ripgrep/fd/fzf, lazygit, stow,
   sqlfluff, terraform, tflint, uv, and friends.
3. `stow` each package above into `$HOME`.

On the first `nvim` launch, `lazy.nvim` will fetch all plugins. Then run
`:Mason` to confirm LSPs/formatters are installed.

### Common flags

```bash
./bootstrap/bootstrap.sh --stow-only      # skip package install, just symlink
./bootstrap/bootstrap.sh --packages-only  # install packages, don't touch $HOME
```

### Uninstall

```bash
./uninstall.sh
```

Removes only the symlinks (your $HOME-side plugin caches at
`~/.local/share/nvim`, `~/.cache/nvim`, etc., are left alone).

## Neovim — what's included

- **lazy.nvim** for plugin mgmt, **mason** for LSP/formatter installation
- **Treesitter** parsers for sql, python, terraform, hcl, yaml, json, jinja, …
- **LSP**: basedpyright, ruff, terraformls, yamlls (+ SchemaStore), jsonls, sqlls,
  taplo, lua_ls, bashls, dockerls, marksman
- **Format-on-save** via conform.nvim: ruff_format, sqlfluff, terraform_fmt, prettier, stylua
- **Lint-on-save** via nvim-lint: ruff, sqlfluff, tflint, hadolint
- **dbt**: `dbtpal` (`<leader>drm`/`<leader>dtm`/`<leader>dC`) + Jinja-aware SQL
- **Databases**: vim-dadbod + dadbod-ui (`<leader>Du`) for Snowflake/Postgres/SQLite
- **Python**: venv-selector (`<leader>vs`), nvim-dap-python (`<leader>db`/`<leader>dc`)
- **Git**: gitsigns, neogit (`<leader>gg`), diffview (`<leader>gd`), lazygit (`<leader>gl`)
- **Telescope** for fuzzy find: files (`<leader>sf`), grep (`<leader>sg`), …
- **Oil.nvim** as a buffer-style file explorer (`-`)

Optional AI assistants (Copilot, CodeCompanion) are wired up but **disabled** by
default — set `vim.g.enable_ai = true` near the top of `init.lua` to turn on.

## Snowflake querying via :DBUI

After bootstrap, in any Python venv (or system-wide via `uv pip --system`):

```bash
uv pip install snowflake-connector-python snowflake-sqlalchemy
```

Then in Neovim:

```
:DBUIAddConnection
# Name: snowflake-dev
# URL:  snowflake://USER:PASS@ACCOUNT/DB/SCHEMA?warehouse=WH&role=ROLE
:DBUIToggle      " <leader>Du
```

Connection definitions are stored at `~/.local/share/db_ui/connections.json`
(machine-local; never committed).
