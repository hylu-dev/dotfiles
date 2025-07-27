-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Rust-specific keybindings
vim.keymap.set("n", "<leader>rr", "<cmd>RustRun<CR>", { desc = "Run Rust project" })
vim.keymap.set("n", "<leader>rt", "<cmd>RustTest<CR>", { desc = "Run Rust tests" })
