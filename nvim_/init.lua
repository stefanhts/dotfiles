-- 1. Mapleader MUST be defined before any requires that use it
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Requires
require("stefanhts.set")
require("stefanhts.remap")
require("config.lazy")

-- 3. Options
vim.o.ignorecase = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'

-- 4. Autocommands
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})
