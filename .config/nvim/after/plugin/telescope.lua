require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "/vendor/", "vendor/" }
    },
    pickers  = {
        find_files = {
            theme = "ivy"
        }
    }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>gg', builtin.git_status, { desc = '[?] Find git files' })
vim.keymap.set('n', '<leader>gst', builtin.git_stash, { desc = '[?] Find git stash files' })
vim.keymap.set('n', '<leader>ts', builtin.treesitter, { desc = '[?] List treesitter objects' })
vim.keymap.set('n', '<leader>p', builtin.treesitter, { desc = '[?] [P]lanets' })

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
