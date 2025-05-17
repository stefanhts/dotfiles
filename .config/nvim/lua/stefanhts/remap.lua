vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-w>", "<Esc>:w<CR>")
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])

vim.keymap.set("n", ",", "f,")
vim.keymap.set("v", ",", "f,")

vim.keymap.set("n", "<leader>h", "<CR>ws")
vim.keymap.set("n", "<leader>v", "<CR>wv")

vim.keymap.set("n", "<leader>ca", "<Esc>:only<CR>")

vim.keymap.set("n", "<leader>vvf", "<Esc>:e ~/.config/nvim<Enter>")
vim.keymap.set("n", "<leader>cf", "<Esc>:e ~/.zshrc<Enter>")


-- Nice remap to make Go less painfull
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Make vertical movements nice
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("i", "<C-u>", "<C-u>zz")
vim.keymap.set("i", "<C-d>", "<C-d>zz")


vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<leader>t", ":belowright split | resize 20 | terminal<CR>")
