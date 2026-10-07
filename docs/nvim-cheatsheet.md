# Neovim IDE cheatsheet

Quick reference for the data-engineering Neovim setup in this repo.

Neovim's mental model isn't VS Code's. There are no IDE-style tabs/panels by
default; instead you have **buffers** (open files), **windows** (splits), and
**tabs** (named workspaces — rarely used). The "IDE" is built from on-demand
commands and `which-key`-discoverable keymaps.

**Leader key is `<Space>`.** Press it and pause — `which-key.nvim` lists every
group/keymap.

## Files & buffers

| Action | Keys |
|---|---|
| Find file by name | `<Space>sf` (Telescope) |
| Live grep across project | `<Space>sg` |
| Recent files | `<Space>s.` |
| Switch buffer | `<Space><Space>` |
| File explorer (current dir) | `-` (oil.nvim — edits like a buffer; `:w` to apply renames/deletes) |
| Help search | `<Space>sh` |
| Keymaps search | `<Space>sk` |

## Windows / splits (the "panes")

| Action | Keys |
|---|---|
| Split right | `:vsplit` or `<C-w>v` |
| Split down | `:split` or `<C-w>s` |
| Move between splits | `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` |
| Close split | `:q` |
| Make current split fullscreen | `<C-w>o` |

## Terminal

- `:terminal` opens a shell in the current window. `<Esc><Esc>` exits
  terminal-mode back to normal mode.
- For real-world DE work, **stay in tmux** (the bootstrap installs it). Use
  tmux panes for terminals (`dbt run`, `airflow tasks test`, …) and Neovim
  for editing. WezTerm + tmux + Neovim is the canonical layout.
- Quick git terminal: `<Space>gl` opens lazygit in a floating Neovim window.

## LSP (any file with an attached language server)

| Action | Keys |
|---|---|
| Go to definition | `gd` |
| Find references | `gr` |
| Hover docs | `K` |
| Rename symbol | `<Space>rn` |
| Code action (quickfix/refactor) | `<Space>ca` |
| Document symbols | `<Space>ds` |
| Workspace symbols | `<Space>ws` |
| Format buffer | `<Space>f` (also format-on-save) |

## Diagnostics

| Action | Keys |
|---|---|
| Project diagnostics panel | `<Space>xx` (Trouble) |
| Buffer-only diagnostics | `<Space>xX` |
| Diagnostics list (Telescope) | `<Space>sd` |
| Quickfix from diagnostics | `<Space>q` |

## Git

| Action | Keys |
|---|---|
| Stage hunk / preview hunk | `<Space>hs` / `<Space>hp` (gitsigns) |
| Neogit (full UI) | `<Space>gg` |
| Diffview (3-way) | `<Space>gd` |
| File history | `<Space>gh` |
| Lazygit | `<Space>gl` |

## Databases (Snowflake, Postgres, …)

| Action | Keys |
|---|---|
| DBUI panel | `<Space>Du` |
| Add a connection | `<Space>Da` |
| Find DBUI buffer | `<Space>Df` |
| Run query (in `.sql` opened from DBUI) | `<C-Space>` (default DBUI keymap) |

## dbt (in any `.sql` inside a dbt project)

| Action | Keys |
|---|---|
| Run current model | `<Space>drm` |
| Test current model | `<Space>dtm` |
| Compile current model | `<Space>dC` |
| Run all | `<Space>dra` |

## Python

| Action | Keys |
|---|---|
| Pick virtualenv | `<Space>vs` (venv-selector — finds `.venv`, uv, pyenv) |
| Toggle breakpoint | `<Space>db` |
| Continue / step | `<Space>dc` / `<Space>dn` / `<Space>di` / `<Space>do` |
| Toggle debug UI | `<Space>du` |

## Search / find anything

- `<Space>st` — TODOs in project
- `<Space>sr` — resume last Telescope picker
- Inside Telescope: `<C-q>` sends results to quickfix, `<C-x>` / `<C-v>`
  opens in a horizontal / vertical split

## Toggle helpers

- `<Esc>` clears search highlight
- `<Space>` followed by any prefix shows which-key — your living cheatsheet

## A typical session

1. `cd ~/projects/my-dbt-repo` then `nvim .`
2. `-` to browse the tree, pick a model.
3. `<Space>sg` to grep for a column name across the project.
4. Edit. Format-on-save runs `sqlfluff` for `.sql` and `ruff_format` for `.py`.
5. Drop into a tmux pane for `dbt run -s my_model` (or `<Space>drm` to do it
   from inside Neovim).
6. `<Space>Du` to open DBUI, run a query against Snowflake to spot-check the
   result.
7. `<Space>gg` (Neogit) to stage and commit.

## Tips

- Don't use vim "tabs" the way VS Code does — use buffers (`<Space><Space>`
  to switch). One Neovim window per project, drive the rest with tmux.
- Run `:Mason` once to confirm all language servers/formatters are installed
  (the bootstrap triggers it, but a manual check catches any failure).
- Run `:checkhealth` to verify your install (treesitter parsers, providers, …).
- Read kickstart's structure: `init.lua` is the entrypoint; per-language tweaks
  live in `nvim/.config/nvim/lua/custom/plugins/*.lua` and
  `nvim/.config/nvim/after/ftplugin/<lang>.lua`. Edit those, save, then
  `:source %` or restart `nvim`.
