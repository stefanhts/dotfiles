-- Minimal init.lua for VSCode Neovim (v2 - Corrected API Usage)
-- Disables plugins and maps keys to VSCode commands.

-- -----------------------------------------------------------------------------
-- Basic Editor Settings (from your lua/stefanhts/set.lua)
-- -----------------------------------------------------------------------------
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.g.mapleader = " "

-- -----------------------------------------------------------------------------
-- General Remaps (from your lua/stefanhts/remap.lua)
-- These are standard Vim commands and should work correctly.
-- -----------------------------------------------------------------------------
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- -----------------------------------------------------------------------------
-- Mappings to VSCode Commands (Corrected)
-- This section now uses the correct `require('vscode').action()` API.
-- -----------------------------------------------------------------------------

local function nmap(keys, command, desc)
  vim.keymap.set("n", keys, function()
    -- Use the correct vscode-neovim Lua API
    require('vscode').action(command)
  end, { noremap = true, silent = true, desc = desc })
end

-- Telescope / Snacks Remaps to VSCode Quick Open
nmap('<leader>f', 'workbench.action.quickOpen', '[VSCode] Find Files')
nmap('<leader>o', 'workbench.action.quickOpenRecent', '[VSCode] Find recently opened files')
nmap('<leader>b', 'workbench.action.showAllEditors', '[VSCode] Find existing buffers')
nmap('<leader>sg', 'workbench.action.findInFiles', '[VSCode] Search by Grep')
nmap('<leader>sw', 'actions.findWithSelection', '[VSCode] Search current Word')
nmap('<leader>sh', 'workbench.action.showCommands', '[VSCode] Search Help (Commands)')
nmap('<leader>sd', 'workbench.action.showErrorsWarnings', '[VSCode] Search Diagnostics')
nmap('<leader>p', 'workbench.action.gotoSymbol', '[VSCode] Find Symbols in File')

-- Harpoon Remaps to VSCode Editor/Tab navigation
nmap('<C-e>', 'workbench.action.toggleEditorGroupLayout', '[VSCode] Toggle Editor Layout')
nmap('<leader>a', 'workbench.action.keepEditor', '[VSCode] Pin Current File (like add_file)')
nmap('gl', 'workbench.action.nextEditor', '[VSCode] Next Editor')
nmap('gh', 'workbench.action.previousEditor', '[VSCode] Previous Editor')
nmap('go', 'workbench.action.openEditorAtIndex1', '[VSCode] Go to Editor 1')
nmap('gi', 'workbench.action.openEditorAtIndex2', '[VSCode] Go to Editor 2')
nmap('gu', 'workbench.action.openEditorAtIndex3', '[VSCode] Go to Editor 3')
nmap('gy', 'workbench.action.openEditorAtIndex4', '[VSCode] Go to Editor 4')

-- Diagnostic keymaps
nmap('{d', 'editor.action.marker.prev', 'Go to previous diagnostic message')
nmap('}d', 'editor.action.marker.next', 'Go to next diagnostic message')

-- Other useful mappings
nmap('<leader>ca', 'workbench.action.closeAllEditors', '[VSCode] Close All Editors')
nmap('<leader>lg', 'workbench.view.scm', '[VSCode] Open Source Control (LazyGit)')
