-- WezTerm config — cross-platform, Lua-driven.
-- Docs: https://wezfurlong.org/wezterm/config/files.html
local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- ---- Appearance ----------------------------------------------------------
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'JetBrains Mono',
  'Menlo',
})
config.font_size = 14.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' } -- ligatures on
config.line_height = 1.05
config.window_decorations = 'RESIZE'
config.window_padding = { left = 8, right = 8, top = 6, bottom = 6 }
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 50000

-- ---- Terminal capabilities ----------------------------------------------
-- term=wezterm enables true color + undercurls (LSP diagnostic squiggles).
config.term = 'wezterm'
config.enable_kitty_graphics = true

-- ---- Keys ----------------------------------------------------------------
-- Keep tmux as the multiplexer of record. WezTerm only handles the surface
-- (tabs/windows). Most pane work happens inside tmux via its prefix key.
local act = wezterm.action
config.keys = {
  -- Mac-friendly tab/window mgmt
  { key = 't', mods = 'CMD',       action = act.SpawnTab('CurrentPaneDomain') },
  { key = 'w', mods = 'CMD',       action = act.CloseCurrentTab({ confirm = true }) },
  { key = 'n', mods = 'CMD',       action = act.SpawnWindow },
  { key = 'k', mods = 'CMD',       action = act.ClearScrollback('ScrollbackAndViewport') },
  -- Cross-platform fallback (for Linux where CMD is SUPER)
  { key = 't', mods = 'SUPER',     action = act.SpawnTab('CurrentPaneDomain') },
  { key = 'w', mods = 'SUPER',     action = act.CloseCurrentTab({ confirm = true }) },
  -- Font size
  { key = '+', mods = 'CMD|SHIFT', action = act.IncreaseFontSize },
  { key = '-', mods = 'CMD',       action = act.DecreaseFontSize },
  { key = '0', mods = 'CMD',       action = act.ResetFontSize },
}

-- ---- Per-OS tweaks -------------------------------------------------------
if wezterm.target_triple:find('darwin') then
  config.macos_window_background_blur = 20
  config.window_background_opacity = 0.97
end

return config
