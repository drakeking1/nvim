return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup {
            install_dir = vim.fn.stdpath("data") .. "/site",
        }

        require("nvim-treesitter").install {
            "lua",
            "c",
            "javascript",
            "tsx",
            "typescript",
            "markdown",
            "markdown_inline", -- needed for .md highlighting
            "json",
        }

        -- highlight any filetype with an installed parser
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        -- experimental treesitter-based indentation
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
