require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { 
        "help",
        "javascript",
        "typescript",
        "go",
        "c",
        "lua",
        "rust",
        "ocaml",
        "python",
        "vim",
        "vimdoc",
        "html",
        "markdown",
        "json",
    },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,


  highlight = {
    -- `false` will disable the whole extension
    enable = true,
   -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("treesitter-context").setup { enable = true }


