pcall(require, "impatient")
require("user.plugins")
require("user.colorscheme")
require("user.lualine")
require("user.tidal")

-- Leader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable mouse
vim.o.mouse = "a"
