-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.ignorecase = true

-- scrolling
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8

-- lazygit
vim.g.lazygit_config = false

-- Set leader to ','
vim.g.mapleader = ","
vim.g.maplocalleader = ","
