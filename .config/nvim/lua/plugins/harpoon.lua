return 
{ 
    "ThePrimeagen/harpoon",
    config = function() 
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        vim.keymap.set("n", "gy", function() ui.nav_file(4) end)
        vim.keymap.set("n", "gu", function() ui.nav_file(3) end)
        vim.keymap.set("n", "gi", function() ui.nav_file(2) end)
        vim.keymap.set("n", "go", function() ui.nav_file(1) end)

        vim.keymap.set("n", "gl", function() ui.nav_next() end)
        vim.keymap.set("n", "gh", function() ui.nav_prev() end)
    end
}
