-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("i", "jk", "<Esc>", { desc = "Alias <Esc> in insert mode", remap = true })

-- Function to toggle inline diagnostics
local function toggle_inline_diagnostics()
  local current_setting_signs = vim.diagnostic.config().signs
  local current_setting_underline = vim.diagnostic.config().underline
  local current_setting_virtual_text = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    signs = not current_setting_signs,
    underline = not current_setting_underline,
    virtual_text = not current_setting_virtual_text,
  })
end

-- Set a key mapping for toggling inline diagnostics
vim.keymap.set("n", "<leader>cD", toggle_inline_diagnostics, { desc = "Toggle Inline Diagnostics" })
