local plugins = {
  -- 2. Temas e Cores
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        filter = "pro",
        transparent_background = false,
        terminal_colors = true,
        devicons = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true },
          type = { italic = true },
          storageclass = { italic = true },
          structure = { italic = true },
          parameter = { italic = true },
          annotation = { italic = true },
          tag_attribute = { italic = true },
        },
        background_clear = {
          "toggleterm",
          "telescope",
          "renamer",
          "notify",
        },
        plugins = {
          bufferline = {
            underline_selected = false,
            underline_visible = false,
          },
          indent_blankline = {
            context_highlight = "default",
            context_start_underline = false,
          },
        },
      })
    end
  },

  -- Fuzzy Finder (Telescope)
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  },

  -- Tree-sitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function()
      local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
      if not status_ok then
        return
      end

      configs.setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",

          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "yaml",
          "toml",

          "python",
          "ruby",
          "php",
          "go",
          "rust",
          "java",
          "kotlin",
          "c",
          "cpp",
          "c_sharp",

          "bash",
          "dockerfile",

          "markdown",
          "markdown_inline",

          "sql",
          "graphql",
          "regex",
          "gitcommit",
          "gitignore",
        },

        auto_install = false,
        sync_install = false,

        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },

        indent = {
           enable = true
         },
      })
    end
  }
}

return plugins